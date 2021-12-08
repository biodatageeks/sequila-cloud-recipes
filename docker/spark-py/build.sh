#!/usr/bin/env bash -x
export PYSEQUILA_VERSION="0.3.3"

for tag in gke aks
do
  cd $tag
  docker build \
    -t biodatageeks/spark-py:pysequila-0.3.3-$tag \
    --build-arg PYSEQUILA_VERSION=$PYSEQUILA_VERSION  \
    .
  docker push biodatageeks/spark-py:pysequila-0.3.3-$tag
  cd ..
done