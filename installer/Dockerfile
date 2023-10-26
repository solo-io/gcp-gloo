FROM alpine

ARG GLOO_VERSION
ARG KUBE_MINOR_VERSION=1.28
ARG KUBE_PATCH_VERSION=3

# install glooctl
RUN wget https://github.com/solo-io/gloo/releases/download/v$GLOO_VERSION/glooctl-linux-amd64
RUN chmod +x glooctl-linux-amd64
RUN mv glooctl-linux-amd64 /bin/glooctl
RUN glooctl version

RUN mkdir /var/gloo/
RUN wget https://storage.googleapis.com/solo-public-helm/charts/gloo-$GLOO_VERSION.tgz
RUN mv gloo-$GLOO_VERSION.tgz /var/gloo/gloo.tgz


RUN mkdir -p /opt/kubectl/$KUBE_MINOR_VERSION \
    && wget -q -O /opt/kubectl/$KUBE_MINOR_VERSION/kubectl \
        https://storage.googleapis.com/kubernetes-release/release/v$KUBE_MINOR_VERSION.$KUBE_PATCH_VERSION/bin/linux/amd64/kubectl \
    && chmod 755 /opt/kubectl/$KUBE_MINOR_VERSION/kubectl
RUN mv /opt/kubectl/$KUBE_MINOR_VERSION/kubectl /bin/kubectl

# script used to set owner refs
COPY scripts/setOwner /bin/setOwner
RUN chmod +x /bin/setOwner