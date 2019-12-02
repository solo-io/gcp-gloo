# Gloo

[Gloo Releases](https://github.com/solo-io/gloo/releases)


# Overview

This repo manages two images and a helm chart for running glooctl
- Deployer Image: conforms to GCP Marketplace deployer criteria
- Installer Image: contains the appropriate version of glooctl
- Installer Helm Chart: launches glooctl as a Job, passes values from the schema to glooctl to allow custom installations

## Deployer Image

- The deployer executes this standard [deploy.sh](https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools/blob/master/marketplace/deployer_util/deploy.sh) script
- Deployer launches a Job to install Gloo


## Installer Image

- contains `glooctl` at the appropriate version
- contains helm charts for gloo and gloo-ee
- Job runs glooctl to install either Gloo or Gloo-E
  - if a license is provided, install Gloo-E
  - otherwise install Gloo

## Installer Chart

- launches `glooctl` in a Job
- passes user config from the marketplace schema to `glooctl`
