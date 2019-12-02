# Gloo

[Gloo Releases](https://github.com/solo-io/gloo/releases)

# User config

The user is required to provide the following:
- Name
- Namespace
- (future) helm values file (as link or base64 encoded string)


Rationale:
- the full helm values spec is very expressive/verbose and includes types that are not supported in the marketplace schema
- to get started, install with the defaults
- next step: allow fully custom helm values, ingest them as a file/url for simplicity


# Deployer

- The deployer executes this standard [deploy.sh](https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools/blob/master/marketplace/deployer_util/deploy.sh) script
  - With this constraint, custom code would be most easily executed as a Job
    - The deployer deploys the Job
    - GCP Marketplace flow installs the crds and other restricted resources
    - The Job installs the resources


# Overview

- Deployer launches a Job
- Job runs glooctl to install either Gloo or Gloo-E
  - if a license is provided, install Gloo-E
  - otherwise install Gloo

