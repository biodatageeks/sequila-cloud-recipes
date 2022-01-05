resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.bucket.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket" "bucket" {
  project                     = var.project_name
  name                        = "${var.project_name}-staging"
  location                    = var.region
  uniform_bucket_level_access = false #tfsec:ignore:google-storage-enable-ubla
  force_destroy               = true
  #checkov:skip=CKV_GCP_62: "Bucket should log access"
  #checkov:skip=CKV_GCP_29: "Ensure that Cloud Storage buckets have uniform bucket-level access enabled"

}

locals {
  py_file = <<-EOT
  from pysequila import SequilaSession
  import time
  sequila = SequilaSession.builder \
    .appName("SeQuiLa") \
    .getOrCreate()

  sequila.sql("SET spark.biodatageeks.readAligment.method=disq")
  sequila\
    .pileup(f"gs://${google_storage_bucket.bucket.name}/data/NA12878.multichrom.md.bam",
            f"/mnt/spark/Homo_sapiens_assembly18_chr1_chrM.small.fasta", False) \
    .show(5)
  EOT


  spark_k8s_deployment = <<-EOT
  #
  # Copyright 2018 Google LLC
  #
  # Licensed under the Apache License, Version 2.0 (the "License");
  # you may not use this file except in compliance with the License.
  # You may obtain a copy of the License at
  #
  #     https://www.apache.org/licenses/LICENSE-2.0
  #
  # Unless required by applicable law or agreed to in writing, software
  # distributed under the License is distributed on an "AS IS" BASIS,
  # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  # See the License for the specific language governing permissions and
  # limitations under the License.
  #
  # Support for Python is experimental, and requires building SNAPSHOT image of Apache Spark,
  # with `imagePullPolicy` set to Always

  apiVersion: "sparkoperator.k8s.io/v1beta2"
  kind: SparkApplication
  metadata:
    name: pysequila
    namespace: default
  spec:
    type: Python
    pythonVersion: "3"
    mode: cluster
    image: "docker.io/biodatageeks/spark-py:pysequila-0.3.3"
    imagePullPolicy: Always
    mainApplicationFile: gs://${google_storage_bucket.bucket.name}/jobs/pysequila/sequila-pileup-gke.py
    sparkVersion: "3.1.2"
    sparkConf:
      spark.kubernetes.executor.deleteOnTermination: "false"
    volumes:
      - name: "data"
        persistentVolumeClaim:
          claimName: data
          readOnly: true
    restartPolicy:
      type: OnFailure
      onFailureRetries: 3
      onFailureRetryInterval: 10
      onSubmissionFailureRetries: 5
      onSubmissionFailureRetryInterval: 20
    driver:
      cores: 1
      coreLimit: "1200m"
      memory: "2048m"
      labels:
        version: 3.1.1
      serviceAccount: spark
      volumeMounts:
        - name: data
          mountPath: /mnt/spark
          readOnly: true
    executor:
      cores: 1
      instances: 1
      memory: "2048m"
      labels:
        version: 3.1.1
      volumeMounts:
        - name: data
          mountPath: /mnt/spark
          readOnly: true
  EOT


}


resource "local_file" "py_file" {
  content  = local.py_file
  filename = "../../jobs/gcp/gke/sequila-pileup.py"
}


resource "local_file" "deployment_file" {
  content  = local.spark_k8s_deployment
  filename = "../../jobs/gcp/gke/pysequila.yaml"
}

resource "google_storage_bucket_object" "sequila-pileup" {

  name   = "jobs/pysequila/sequila-pileup.py"
  source = "../../jobs/gcp/dataproc/sequila-pileup.py"
  bucket = google_storage_bucket.bucket.name
}

resource "google_storage_bucket_object" "sequila-pileup-gke" {

  name   = "jobs/pysequila/sequila-pileup-gke.py"
  source = "../../jobs/gcp/gke/sequila-pileup.py"
  bucket = google_storage_bucket.bucket.name
}

resource "google_storage_bucket_object" "sequila-data" {
  for_each = toset(var.data_files)
  name     = "data/${each.value}"
  source   = "../../data/${each.value}"
  bucket   = google_storage_bucket.bucket.name
}

resource "google_storage_bucket_object" "sequila-init-script" {
  for_each = toset(var.data_files)
  name     = "scripts/setup-data.sh"
  source   = "../../scripts/setup-data.sh"
  bucket   = google_storage_bucket.bucket.name
}