FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y curl zip lsb-core graphviz

ENV MDTOC_VERSION=0.2

RUN cd /tmp && \
    curl -L https://github.com/madlambda/mdtoc/releases/download/v${MDTOC_VERSION}/mdtoc-v${MDTOC_VERSION}-linux-amd64.tar.gz > mdtoc.tar.gz && \
    tar xvfz mdtoc.tar.gz -C /usr/bin && \
    rm mdtoc.tar.gz

WORKDIR /data
