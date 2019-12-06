This document outlines how to install Gloo through Google Cloud Marketplace.
For full documenation on Gloo, please see the [complete Gloo documenation](https://docs.solo.io/gloo/latest/)


# Overview

Link to [GCP Marketplace Solution](TODO-when-published)

**Name** indicates what you would like to call the installation. This will be prefixed for some of the installation resources.

**Namespace** indicates the namespace where you would like to deploy Gloo. You can install Gloo to multiple namespaces but you should not deploy more than one set of Gloo instances per namespace.

**License** specifies the license used for Gloo Enterprise. If none is provided, Gloo will be installed instead of Gloo Enterprise.



# One-time setup

A license for Gloo Enterprise can be aquired through https://www.solo.io/products/gloo/

Once installed, you can use `kubectl` and `glooctl` to interact with Gloo.

You can find a version of `glooctl` corresponding to your installation on the [Gloo Releases Page](https://github.com/solo-io/gloo/releases).


# Installation

Commands for deploying the application.
Passing parameters available in UI configuration.
Pinning image references to immutable digests.
If you add custom input fields to your deployer schema, add information about the expected values, if applicable.

Learn about adding input fields to your deployer

# Basic Usage

Connecting to an admin console (if applicable).
Connecting a client tool and running a sample command (if applicable).
Modifying usernames and passwords.
Enabling ingress and installing TLS certs (if applicable).

# Backup and restore

All of Gloo's configuration data is stored in Kubernetes Custom Resource objects. `VirtualServices`, for example, store routing config that describes how requests should be handled. You can use your normal Kubernetes resource management workflow to backup and restore Gloo resources.

# Image updates

Updating the application images for patches or minor updates.

# Scaling

Gloo scales well to arbitrary workloads. Please refer to the [Gloo documenation](https://docs.solo.io/gloo/latest/) for scaling insights, as needed.

# Deletion

Gloo can be deleted with `glooctl`. Please see the docs on the [uninstall](https://docs.solo.io/gloo/latest/cli/glooctl_uninstall/) command.
