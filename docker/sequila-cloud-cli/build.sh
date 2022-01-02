#!/usr/bin/env bash -x
TAG=$(git rev-parse --short HEAD)
docker build \
    --build-arg SEQ_VERSION=$TAG \
    -t biodatageeks/sequila-cloud-cli:$TAG \
    .
docker push biodatageeks/sequila-cloud-cli:$TAG
