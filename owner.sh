#!/bin/bash -xe

# This script applies an owner ref to the resources that match the provided selector
# The owner ref is the Application specified by NAMESPACE and APP_NAME
# Any resources (apart from Pods) which match the --selector=$TARGET_SELECTOR are updated

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

# find all the resources created by the installer
TARGET_META_JSONPATH="{range .items[*]}{.kind},{.metadata.name} {end}"
TARGETS=`kubectl get all -n $NAMESPACE --selector=$TARGET_SELECTOR -o jsonpath="$TARGET_META_JSONPATH"`

# apply the owner ref to each resource
for TARGET in $TARGETS
do
    ARR=(`echo $TARGET | tr "," " "`)
    KIND=${ARR[0]}
    NAME=${ARR[1]}
    case $KIND in
        "Deployment"|"Job"|"ReplicaSet"|"Service")
            kubectl patch -n $NAMESPACE $KIND $NAME --patch "$PATCH"
            ;;
        "Pod")
            echo "skipping $KIND since owner ref is already handled"
            ;;
        *)
            echo "did not expect this resource - please update script to handle it"
            exit 1
            ;;
    esac
done
