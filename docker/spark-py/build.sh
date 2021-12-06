#!/usr/bin/env bash
export PYSEQUILA_VERSION="0.3.3+geff1cba-SNAPSHOT"

docker build \
  -t biodatageeks/spark-py:pysequila-0.3.3 \
  --build-arg PYSEQUILA_VERSION=$PYSEQUILA_VERSION  \
  .

docker push biodatageeks/spark-py:pysequila-0.3.3