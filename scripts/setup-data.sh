#!/bin/bash

set -exo pipefail
env

readonly STAGING_BUCKET=$(/usr/share/google/get_metadata_value attributes/dataproc-bucket || true)

gsutil cp gs://${STAGING_BUCKET}/data/Homo_sapiens_assembly18_chr1_chrM.small.fasta* /tmp/

sudo echo "STAGING_BUCKET=${STAGING_BUCKET}" >> /etc/environment