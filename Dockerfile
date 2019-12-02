# onbuild includes build-time logic that requires the directory to be structured as specified in:
# https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools/blob/master/docs/building-deployer-helm.md
FROM gcr.io/cloud-marketplace-tools/k8s/deployer_helm/onbuild

# https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools/blob/master/docs/mpdev-references.md
# copy some test values for verification
COPY schema_test_values.yaml /data-test/schema.yaml