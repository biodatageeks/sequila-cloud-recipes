resource "aws_s3_object" "sequila-data" {
  for_each = toset(var.data_files)
  bucket   = var.bucket
  key      = "data/${each.value}"
  source   = "../../data/${each.value}"
  acl      = "public-read"
  etag     = filemd5("../../data/${each.value}")
}

locals {
  py_file = <<-EOT
  from pysequila import SequilaSession
  import time
  import os
  sequila = SequilaSession.builder \
    .appName("SeQuiLa") \
    .getOrCreate()
  sequila.sparkContext.setLogLevel("INFO")
  sequila.sql("SET spark.biodatageeks.readAligment.method=disq")
  sequila\
    .pileup(f"s3a://${var.bucket}/data/NA12878.multichrom.md.bam",
            f"Homo_sapiens_assembly18_chr1_chrM.small.fasta", False) \
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
    image: "${var.pysequila_image_eks}"
    imagePullPolicy: Always
    mainApplicationFile: s3a://${var.bucket}/jobs/pysequila/sequila-pileup.py
    sparkVersion: "3.2.2"
    deps:
      files:
        - s3a://${var.bucket}/data/Homo_sapiens_assembly18_chr1_chrM.small.fasta
        - s3a://${var.bucket}/data/Homo_sapiens_assembly18_chr1_chrM.small.fasta.fai
      filesDownloadDir: "/opt/spark/work-dir"
    hadoopConf:
      fs.s3a.aws.credentials.provider: org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider
    sparkConf:
      spark.kubernetes.executor.deleteOnTermination: "false"
      spark.executor.extraClassPath: "/opt/spark/.ivy2/jars/*"
      spark.driver.extraClassPath: "/opt/spark/.ivy2/jars/*"
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
  EOT


}


resource "local_file" "deployment_file" {
  content  = local.spark_k8s_deployment
  filename = "../../jobs/aws/eks/pysequila.yaml"
}

resource "aws_s3_object" "sequila-pileup" {
  key     = "jobs/pysequila/sequila-pileup.py"
  content = local.py_file
  bucket  = var.bucket
  acl     = "public-read"
}