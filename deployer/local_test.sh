#!/bin/bash -e -x

# run modified versions of the mpdev scripts locally for easier debugging

rm -rf data
rm -rf tmp
mkdir -p data/values
mkdir -p data/extracted

mkdir data/final_values/
# cp chart/gloo/values.yaml data/values.yaml
cp mocval.yaml data/values.yaml

# generate the values template
NAME=test NAMESPACE=tmp ../../../GoogleCloudPlatform/marketplace-k8s-app-tools/marketplace/deployer_util/expand_config.py --values_mode raw --app_uid 84bb2790-0407-11ea-85ea-42010a800024

cat data/final_values.yaml

# prepare zipped chart, as is done by onbuild container
mkdir -p tmp/
cp -r chart tmp/chart.tmp
mv tmp/chart.tmp/* tmp/chart
cd tmp
tar -czvf chart.tar.gz chart/*
cd ..
mkdir -p data/chart
mv tmp/chart.tar.gz data/chart/
# rm -Rf tmp/chartTEMP tmp/chart.tmp
# ls data/
# ls data/chart
# ls data/extracted
# ls data/extracted/chart
# exit
# generate manifests
NAME=test NAMESPACE=tmp ../../../GoogleCloudPlatform/marketplace-k8s-app-tools/marketplace/deployer_helm_base/create_manifests.sh

rm -r data
