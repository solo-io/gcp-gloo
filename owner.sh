#!/bin/bash -xe

# assert parameters

if [ -z $NAMESPACE == "" ]; then
    echo "must pass NAMESPACE to identify the target namespace"
    exit 1
fi

if [ -z "$APP_NAME" ]; then
    echo "must pass APP_NAME to identify the application which will be used as the owner"
    exit 1
fi

if [ -z "$TARGET_SELECTOR" ]; then
    echo "must pass TARGET_SELECTOR to identify the resources which should recieve the owner ref"
    exit 1
fi


# get the application uid
APP_UID_JSONPATH="{.metadata.uid}"
APP_UID=`kubectl get application $APP_NAME -n $NAMESPACE -o jsonpath=$APP_UID_JSONPATH`
echo $APP_UID


# format it to a patch
PATCH=$(cat << EOM
metadata:
  ownerReferences:
  - apiVersion: app.k8s.io/v1beta1
    kind: Application
    name: $APP_NAME
    uid: $APP_UID
EOM
)

kubectl patch -n $NAMESPACE deployment gloo --patch "$PATCH"
exit

# find all the resources created by the Installer using a known selector
TARGET_META_JSONPATH="{.items[*].metadata.uid}"
TARGETS=`kubectl get all -n $NAMESPACE --selector=$TARGET_SELECTOR -o jsonpath=$TARGET_META_JSONPATH`
echo $TARGETS
kubectl get all -n $NAMESPACE --selector=$TARGET_SELECTOR -o=jsonpath=$TARGET_META_JSONPATH

# apply the owner ref to each resource
kubectl patch -n $NAMESPACE deployment gloo --patch $PATCH

