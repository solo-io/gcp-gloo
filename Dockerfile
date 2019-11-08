FROM gcr.io/cloud-marketplace-tools/k8s/deployer_helm/onbuild

# COPY schema.yaml /tmp/schema.yaml

ENTRYPOINT ["echo", "test2"]