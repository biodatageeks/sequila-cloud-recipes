resource "azurerm_storage_blob" "sequila" {
  for_each               = toset(var.data_files)
  name                   = "data/${each.value}"
  storage_account_name   = var.storage_account
  storage_container_name = var.storage_container
  type                   = "Block"
  source                 = "../../data/${each.value}"
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
    .pileup(f"wasb://sequila@${var.storage_account}.blob.core.windows.net/data/NA12878.multichrom.md.bam",
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
    image: "${var.pysequila_image_aks}"
    imagePullPolicy: Always
    mainApplicationFile: wasb://sequila@${var.storage_account}.blob.core.windows.net/jobs/pysequila/sequila-pileup.py
    sparkVersion: "3.2.2"
    deps:
      files:
        - wasb://sequila@${var.storage_account}.blob.core.windows.net/data/Homo_sapiens_assembly18_chr1_chrM.small.fasta
        - wasb://sequila@${var.storage_account}.blob.core.windows.net/data/Homo_sapiens_assembly18_chr1_chrM.small.fasta.fai
      filesDownloadDir: "/opt/spark/work-dir"
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



resource "local_file" "foo" {
  content  = local.py_file
  filename = "../../jobs/azure/aks/sequila-pileup.py"
}


resource "azurerm_storage_blob" "sequila-pileup" {
  name                   = "jobs/pysequila/sequila-pileup-aks.py"
  storage_account_name   = var.storage_account
  storage_container_name = var.storage_container
  type                   = "Block"
  source                 = "../../jobs/azure/aks/sequila-pileup.py"

}
