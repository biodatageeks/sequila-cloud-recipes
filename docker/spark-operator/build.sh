#!/usr/bin/env bash -x
for tag in gke aks eks
do
  cd $tag
  docker build \
    -t biodatageeks/spark-operator:v1beta2-1.2.3-3.1.2-$tag \
    .
  docker push biodatageeks/spark-operator:v1beta2-1.2.3-3.1.2-$tag
  cd ..
done