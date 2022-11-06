#!/usr/bin/env bash

pysequila_version=$1
resources_dir=$2
jars_dir=$3

DOCKER_BUILDKIT=1 docker build --build-arg BASE_IMAGE=biodatageeks/spark-py:pysequila-${pysequila_version}-base-latest \
   -f ${resources_dir}/Dockerfile.jars \
   --output ${jars_dir} . &>/dev/null
jars=$(ls -1 $jars_dir/)
jq -n --arg inarr "${jars}" '{ jars: $inarr | split("\n") | join(",") }'