# https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools/blob/master/marketplace/deployer_helm_base/onbuild/Dockerfile
FROM gcr.io/cloud-marketplace-tools/k8s/deployer_helm/onbuild

# https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools/blob/master/marketplace/deployer_helm_base/Dockerfile
# The base image is using helm v2.8.1 which does not include the kebabcase (sprig) function we need
# This updates the helm binary to the first release which includes kebabcase.
RUN mkdir -p /bin/helm-downloaded \
    && wget -q -O /bin/helm-downloaded/helm.tar.gz \
        https://storage.googleapis.com/kubernetes-helm/helm-v2.15.0-linux-amd64.tar.gz \
    && tar -zxvf /bin/helm-downloaded/helm.tar.gz -C /bin/helm-downloaded \
    && mv /bin/helm-downloaded/linux-amd64/helm /bin/ \
    && rm -rf /bin/helm-downloaded
