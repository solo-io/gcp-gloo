# Tasks

## Release a new version of Gloo

## Update the images for a given version of Gloo

summary: publish a new deployer image that references the correct values

- Update the versions of gloo and glooe that are listed in `scripts/sync_images/main.go`
- Run the mirror script to host these versions of the images in the GCR repo: `make docker-mirror`
- Run `make mpdev-verify` to confirm that the new images deploy correctly.
  - Verification requires that all resources are installed and deleted.
  - Currently, successful runs take 2-3 minutes. Failing runs time out after about 5 minutes.

# Notes

## Schema

- It is a marketplace requirement that all images be hosted in gcr, under solo-io-public
- The images must be passed through the schema for optional customization
  - images are specified as an image uri string and parsed into `registry`, `repo`, and `tag` components
- We will use the convention of ingesting these values as shown below:
```
fullUri: glooImages.gloo.full
registry: glooImages.gloo.registry
repo: glooImages.gloo.repository
tag: glooImages.gloo.tag
```
- Images belonging to glooe that are not part of gloo will be nested under `glooEImages` instead of `glooImages`
