#!/usr/bin/env bash -x
export PYSEQUILA_VERSION="0.4.1"
export PYSEQUILA_VERSION_SEM=$(echo $PYSEQUILA_VERSION| cut -d"+" -f1)
export SEQUILA_VERSION="1.1.0"
export SPARK_VERSION="3.2.2"
export EXTRA_PIP_INDEX="https://zsibio.ii.pw.edu.pl/nexus/repository/bdg-pip/simple"
export EXTRA_MVN_REPO="https://zsibio.ii.pw.edu.pl/nexus/repository/maven-snapshots/"
export BASE_IMAGE=apache/spark-py:v${SPARK_VERSION}
git_sha=$(git rev-parse --short HEAD)

for tag in base gke dataproc aks
do
  if [ $tag == "dataproc" ]; then
    export BASE_IMAGE=biodatageeks/spark-py:pysequila-${PYSEQUILA_VERSION_SEM}-"gke"-$git_sha
  elif [ $tag != "base" ]; then
    export BASE_IMAGE=biodatageeks/spark-py:pysequila-${PYSEQUILA_VERSION_SEM}-"base"-$git_sha
  fi
  cd $tag
  docker build \
    -t biodatageeks/spark-py:pysequila-${PYSEQUILA_VERSION_SEM}-$tag-$git_sha \
    --build-arg SEQUILA_VERSION="${SEQUILA_VERSION}"  \
    --build-arg PYSEQUILA_VERSION="${PYSEQUILA_VERSION}"  \
    --build-arg SPARK_VERSION=$SPARK_VERSION  \
    --build-arg BASE_IMAGE=$BASE_IMAGE \
    --build-arg EXTRA_PIP_INDEX=$EXTRA_PIP_INDEX \
    --build-arg EXTRA_MVN_REPO=$EXTRA_MVN_REPO \
    .
  docker push biodatageeks/spark-py:pysequila-${PYSEQUILA_VERSION_SEM}-$tag-$git_sha
  docker tag biodatageeks/spark-py:pysequila-${PYSEQUILA_VERSION_SEM}-$tag-$git_sha biodatageeks/spark-py:pysequila-${PYSEQUILA_VERSION_SEM}-$tag-latest
  docker push biodatageeks/spark-py:pysequila-${PYSEQUILA_VERSION_SEM}-$tag-latest
  cd ..
done