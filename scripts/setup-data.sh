#!/bin/bash

set -exo pipefail
env
DP_WORKDIR=/opt/spark/work-dir
readonly STAGING_BUCKET=$(/usr/share/google/get_metadata_value attributes/dataproc-bucket || true)
mkdir -p ${DP_WORKDIR}
gsutil cp gs://${STAGING_BUCKET}/data/Homo_sapiens_assembly18_chr1_chrM.small.fasta* ${DP_WORKDIR}/

sudo echo "STAGING_BUCKET=${STAGING_BUCKET}" >> /etc/environment