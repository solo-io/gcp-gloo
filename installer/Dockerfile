FROM alpine

# install glooctl
# TODO: templatize with the version
RUN wget https://github.com/solo-io/gloo/releases/download/v1.0.0/glooctl-linux-amd64
RUN chmod +x glooctl-linux-amd64
RUN mv glooctl-linux-amd64 /bin/glooctl
RUN glooctl version

RUN mkdir /var/gloo/
RUN wget https://storage.googleapis.com/solo-public-helm/charts/gloo-1.0.0.tgz
RUN mv gloo-1.0.0.tgz /var/gloo/gloo-1.0.0.tgz


RUN mkdir -p /opt/kubectl/1.16 \
    && wget -q -O /opt/kubectl/1.16/kubectl \
        https://storage.googleapis.com/kubernetes-release/release/v1.16.2/bin/linux/amd64/kubectl \
    && chmod 755 /opt/kubectl/1.16/kubectl
RUN mv /opt/kubectl/1.16/kubectl /bin/kubectl