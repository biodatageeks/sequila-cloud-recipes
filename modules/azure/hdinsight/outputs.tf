output "hdinsight_gateway_password" {
  value = var.gateway_password
}

output "hdinsight_ssh_password" {
  value = var.node_ssh_password
}

output "ssh_command" {
  value = "ssh sequila@sequila-${random_string.random-suffix.result}-ssh.azurehdinsight.net"
}

output "pysequila_submit_command" {
  value = <<-EOT
  export SPARK_HOME=/opt/spark
  spark-submit \
  --master yarn \
  --packages org.biodatageeks:sequila_2.12:${var.sequila_version} \
  --conf spark.pyspark.python=/usr/bin/miniforge/envs/py38/bin/python3 \
  --conf spark.driver.cores=1 \
  --conf spark.driver.memory=1g \
  --conf spark.executor.cores=1 \
  --conf spark.executor.memory=3g \
  --conf spark.executor.instances=1 \
  --conf spark.files=${join(",", var.data_files)} \
  wasb://sequila@${var.storage_account_name}.blob.core.windows.net/jobs/pysequila/sequila-pileup.py
  EOT
}