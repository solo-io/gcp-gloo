#!/bin/sh -x -e

# list of images in the gloo helm chart, gathered from:
# rg repo install/helm/gloo/values-gateway-template.yaml | cut -d ':' -f 2
BINARIES="discovery gateway gateway-conversion certgen gloo-envoy-wrapper access-logger"
VERSION=0.21.0
PRODUCT_DIR=gloo
APP_DIR=services
REGISTRY=gcr.io/solo-io-public

for BINARY in $BINARIES
do
    # write a temporary docker file
    SOURCE_IMAGE=quay.io/solo-io/$BINARY:$VERSION
    TMP_DOCKERFILE=tmp.Dockerfile
    echo FROM $SOURCE_IMAGE > $TMP_DOCKERFILE
    # use the temporary docker file to publish a mirror in the marketplace repo
    # scope the images by $APP_DIR in order to keep app images separate from utility images stored in the repo
    MIRROR_IMAGE=$REGISTRY/$PRODUCT_DIR/$APP_DIR/$BINARY:$VERSION
	  docker build -t $MIRROR_IMAGE images -f $TMP_DOCKERFILE
	  docker push $MIRROR_IMAGE
done

rm tmp.Dockerfile
