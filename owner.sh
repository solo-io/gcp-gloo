#!/bin/bash -xe

# assert parameters

if [ -z $NAMESPACE == "" ]; then
    echo "must pass NAMESPACE to identify the target namespace"
    exit 1
fi

if [ -z "$OWNER_REF_SOURCE_TYPE" ]; then
    echo "must pass OWNER_REF_SOURCE_TYPE to identify the type of resource to use when finding the owner ref source"
    exit 1
fi

if [ -z "$OWNER_REF_SOURCE_NAME" ]; then
    echo "must pass OWNER_REF_SOURCE_NAME to identify the name of the resource to use when finding the owner ref source"
    exit 1
fi

if [ -z "$TARGET_SELECTOR" ]; then
    echo "must pass TARGET_SELECTOR to identify the resources which should recieve the owner ref"
    exit 1
fi


# get the owner ref spec from the Job

APP_OWNER_REF_JSONPATH="{.metadata.ownerReferences[0]}"
SOURCE_OWNER_REF=`kubectl get $OWNER_REF_SOURCE_TYPE $OWNER_REF_SOURCE_NAME -n $NAMESPACE -o jsonpath="${APP_OWNER_REF_JSONPATH}"`


JSON_STRING=$( jq -n \
                  --arg bn "$SOURCE_OWNER_REF" \
                  '{bucketname: [$bn]}' )

# format it to a patch
PATCH='{"metadata":{"ownerReferences":'${SOURCE_OWNER_REF}'}}'
PATCH=$( jq -n \
                  --arg bn "$SOURCE_OWNER_REF" \
                  '{"metadata":{"ownerReferences": [$bn]}}' )
echo $PATCH | jq '.'
kubectl patch -n $NAMESPACE deployment gloo --patch "$(echo $PATCH | jq '.')"
exit

# find all the resources created by the Installer using a known selector
TARGET_META_JSONPATH="{.items[*].metadata.uid}"
TARGETS=`kubectl get all -n $NAMESPACE --selector=$TARGET_SELECTOR -o jsonpath=$TARGET_META_JSONPATH`
echo $TARGETS
kubectl get all -n $NAMESPACE --selector=$TARGET_SELECTOR -o=jsonpath=$TARGET_META_JSONPATH

# apply the owner ref to each resource
kubectl patch -n $NAMESPACE deployment gloo --patch $PATCH

