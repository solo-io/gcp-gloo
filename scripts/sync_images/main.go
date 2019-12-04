package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"

	"github.com/pkg/errors"
)

func main() {
	err := run(getOptions())
	if err != nil {
		log.Fatalf("error while running: %v", err)
	}
}

type Options struct {
	DryRun bool
}

func getOptions() *Options {
	opts := &Options{}
	flag.BoolVar(&opts.DryRun, "dry-run", false, "if set, will only show repo mappings, will not sync images")
	flag.Parse()
	return opts
}

// This script mirrors images from Gloo's main distribution repo to the GRP Marketplace repo
// In summary, it pulls the appropriate gloo image versions, tags them as needed for the marketplace, and pushes them to the marketplace repo

const (
	MainDistributionRepoRoot = "quay.io/solo-io"
	GlooSolutionName         = "gloo"
	GlooSourceVersion        = "1.1.0"
	// will need to add another one of these when we add another version of the product to the GCP Marketplace
	GlooDestinationVersion    = "1.1.0"
	OrganizationRepoRoot      = "gcr.io/solo-io-public"
	GlooImageName             = "gloo"
	DiscoveryImageName        = "discovery"
	GatewayImageName          = "gateway"
	CertgenImageName          = "certgen"
	GlooEnvoyWrapperImageName = "gloo-envoy-wrapper"
	AccessLoggerImageName     = "access-logger"
)

type ImageToSync struct {
	// what to call the image, relative to its position in the repo
	// ex: gcr.io/some/path/[DestinationImageName]:someVersion
	// Currently, the names of the images in the mirror repo match the names used in the source repo. If that changes in
	// the future another field will be needed.
	ImageName string

	// only one image may be the primary image, used to infer where to put the image
	IsPrimary bool

	// optional, will be inferred from the the repo containing the source image
	SourceRepoRoot string

	// optional, if set will override the SyncImageBatch version
	SourceVersion string
}

type SyncImageDefaults struct {
	DefaultSourceVersion string
	DefaultSourceRepo    string
	// version of the image that will be hosted in the marketplace
	DestinationVersion string
	// ex: gcr.io/solo-io-public/solutionName
	OrganizationRepoRoot string
	SolutionName         string
}
type SyncImageBatch struct {
	Images   []*ImageToSync
	Defaults *SyncImageDefaults
}

var imagesToSync = []*ImageToSync{{
	ImageName: GlooImageName,
	IsPrimary: true,
}, {
	ImageName: DiscoveryImageName,
}, {
	ImageName: GatewayImageName,
}, {
	ImageName: CertgenImageName,
}, {
	ImageName: GlooEnvoyWrapperImageName,
}, {
	ImageName: AccessLoggerImageName,
}}

var syncImageBatch = SyncImageBatch{
	Images: imagesToSync,
	Defaults: &SyncImageDefaults{
		DefaultSourceVersion: GlooSourceVersion,
		DefaultSourceRepo:    MainDistributionRepoRoot,
		DestinationVersion:   GlooDestinationVersion,
		OrganizationRepoRoot: OrganizationRepoRoot,
		SolutionName:         GlooSolutionName,
	},
}

// Only two arguments are really needed but this signature provides minor validation and keeps the function signature
// the same in both image repo helper functions.
func getPrimaryImageDestinationRepo(destinationRepoRoot, solutionName, imageName string) (string, error) {
	if imageName != solutionName {
		return "", errors.Errorf("primary image name must match solution name, go %v and %v", imageName, solutionName)
	}
	return fmt.Sprintf("%v/%v", destinationRepoRoot, imageName), nil
}
func mustString(str string, err error) string {
	if err != nil {
		log.Fatalf("string, must not error: %v", err)
	}
	return str
}
func getSupportingImageDestinationRepo(destinationRepoRoot, solutionName, imageName string) string {
	return fmt.Sprintf("%v/%v/%v", destinationRepoRoot, solutionName, imageName)
}

func run(opts *Options) error {
	for _, img := range syncImageBatch.Images {
		source := sourceSpecForImage(img, syncImageBatch.Defaults)
		mirror := mirrorSpecForImage(img, syncImageBatch.Defaults)
		fmt.Printf("mirroring from: %v\nto: %v\n", source, mirror)
		if !opts.DryRun {
			if err := createMirrorImage(source, mirror); err != nil {
				return err
			}
		}
	}
	return nil
}

func sourceSpecForImage(img *ImageToSync, batch *SyncImageDefaults) string {
	repoRoot := batch.DefaultSourceRepo
	if img.SourceRepoRoot != "" {
		repoRoot = img.SourceRepoRoot
	}
	version := batch.DefaultSourceVersion
	if img.SourceVersion != "" {
		version = img.SourceVersion
	}
	return fmt.Sprintf("%v/%v:%v", repoRoot, img.ImageName, version)
}
func mirrorSpecForImage(img *ImageToSync, batch *SyncImageDefaults) string {
	repoRoot := batch.OrganizationRepoRoot
	version := batch.DestinationVersion
	if img.IsPrimary {
		return fmt.Sprintf("%v/%v:%v", repoRoot, img.ImageName, version)
	}
	return fmt.Sprintf("%v/%v/%v:%v", repoRoot, batch.SolutionName, img.ImageName, version)
}

// source and mirror images should include registry, name, and version
// ex: gcr.io/some/name:someVersion
func createMirrorImage(sourceImage, mirrorImage string) error {
	if err := validateImageVersion(sourceImage); err != nil {
		return fmt.Errorf("invalid source image: %v", err)
	}
	if err := validateImageVersion(mirrorImage); err != nil {
		return fmt.Errorf("invalid mirror image: %v", err)
	}
	// docker pull source
	pullCmd := exec.Command("docker", "pull", sourceImage)
	pullCmd.Stdout = os.Stdout
	pullCmd.Stderr = os.Stderr
	if err := pullCmd.Run(); err != nil {
		return errors.Wrapf(err, "could not run docker pull")
	}
	// docker tag source mirror
	tagCmd := exec.Command("docker", "tag", sourceImage, mirrorImage)
	tagCmd.Stdout = os.Stdout
	tagCmd.Stderr = os.Stderr
	if err := tagCmd.Run(); err != nil {
		return errors.Wrapf(err, "could not run docker tag")
	}
	// docker push mirror
	pushCmd := exec.Command("docker", "push", mirrorImage)
	pushCmd.Stdout = os.Stdout
	pushCmd.Stderr = os.Stderr
	if err := pushCmd.Run(); err != nil {
		return errors.Wrapf(err, "could not run docker push")
	}
	return nil
}

const versionDelimeter = ":"

func validateImageVersion(spec string) error {
	versionSplit := strings.Split(spec, versionDelimeter)
	if len(versionSplit) != 2 {
		return fmt.Errorf("invalid image spec, (expected format: gcr.io/some/name:version) (got: %v)", spec)
	}
	if versionSplit[1] == "" {
		return fmt.Errorf("must provide a version, none specified for %v", spec)
	}
	return nil
}
