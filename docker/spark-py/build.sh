#!/usr/bin/env bash
export PYSEQUILA_VERSION=0.3.2

docker build \
  -t biodatageeks/spark-py:pysequila-${PYSEQUILA_VERSION} \
  --build-arg PYSEQUILA_VERSION=$PYSEQUILA_VERSION  \
  .

docker push biodatageeks/spark-py:pysequila-${PYSEQUILA_VERSION}