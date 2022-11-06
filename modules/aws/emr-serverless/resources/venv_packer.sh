#!/usr/bin/env bash

pysequila_version=$1
resources_dir=$2

DOCKER_BUILDKIT=1 docker build \
  -f ${resources_dir}/Dockerfile.venv \
  --build-arg PYSEQUILA_VERSION=$pysequila_version \
  --output ${resources_dir}/venv .