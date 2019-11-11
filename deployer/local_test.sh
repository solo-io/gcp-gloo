#!/bin/bash -e -x

# run modified versions of the mpdev scripts locally for easier debugging

mkdir -p data/values

NAME=test NAMESPACE=tmp ../../../GoogleCloudPlatform/marketplace-k8s-app-tools/marketplace/deployer_util/expand_config.py --values_mode raw --app_uid 84bb2790-0407-11ea-85ea-42010a800024

cat data/final_values.yaml

rm -r data
