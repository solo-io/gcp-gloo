#!/bin/sh -xe

CUR_DIR=$(pwd)
TEMP_DIR=$(mktemp -d)

cd $TEMP_DIR

git clone git@github.com:helm/helm.git

cd helm

# Update gRPC dependency to version where
# [GHSA-m425-mq94-257g](https://github.com/advisories/GHSA-m425-mq94-257g) is patched
go get google.golang.org/grpc@v1.56.3

# Build the binaries for all architectures
make build-cross

# Use the linux-amd64 one as that is the architecture the deployer image is based on
mkdir -p $CUR_DIR/helm-linux-amd64
cp -r _dist/linux-amd64/helm $CUR_DIR/helm