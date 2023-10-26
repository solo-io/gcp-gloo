# onbuild includes build-time logic that requires the directory to be structured as specified in:
# https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools/blob/master/docs/building-deployer-helm.md
FROM gcr.io/cloud-marketplace-tools/k8s/deployer_helm/onbuild

# Remove existing kubectl binaries
RUN rm -rf /opt/kubectl

# Copied from here:
# https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools/blob/b9aeb72dfa1ae1a725691c8265911ed456c679e5/marketplace/deployer_helm_base/Dockerfile#L20
RUN for full_version in 1.28.3;  \
     do \
        version=${full_version%.*} \
        && mkdir -p /opt/kubectl/$version \
        && wget -q -O /opt/kubectl/$version/kubectl \
            https://storage.googleapis.com/kubernetes-release/release/v$full_version/bin/linux/amd64/kubectl \
        && chmod 755 /opt/kubectl/$version/kubectl; \
     done;
RUN ln -s /opt/kubectl/1.28 /opt/kubectl/default