FROM vmware/photon

ENV GOVERSION=1.8.4
ENV PATH=$PATH:/root/gsutil:/usr/local/go/bin

RUN set -eux; \
    tdnf install -y make tar gzip python2 python-pip sed git gawk docker; \
    curl -L'#' -k https://storage.googleapis.com/pub/gsutil.tar.gz | tar xzf - -C $HOME;  \
    curl -L'#' -k https://storage.googleapis.com/golang/go$GOVERSION.linux-amd64.tar.gz | tar xzf - -C /usr/local;
