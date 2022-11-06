output "emr_server_exec_role_arn" {
  description = "ARN of EMR Serverless execution role"
  value       = aws_iam_role.EMRServerlessS3RuntimeRole.arn
}

output "emr_serverless_command" {
  description = "EMR Serverless command to run a sample SeQuiLa job"
  value       = <<-EOT
    export APPLICATION_ID=${aws_emrserverless_application.emr-serverless.id}
    export JOB_ROLE_ARN=${aws_iam_role.EMRServerlessS3RuntimeRole.arn}

    aws emr-serverless start-job-run \
      --application-id $APPLICATION_ID \
      --execution-role-arn $JOB_ROLE_ARN \
      --job-driver '{
          "sparkSubmit": {
              "entryPoint": "s3://${var.bucket}/jobs/pysequila/sequila-pileup.py",
              "entryPointArguments": ["pyspark_pysequila-${var.pysequila_version}.tar.gz"],
              "sparkSubmitParameters": "--conf spark.dynamicAllocation.enabled=false --conf spark.driver.cores=1 --conf spark.driver.memory=2g --conf spark.executor.cores=1 --conf spark.executor.memory=4g --conf spark.executor.instances=1 --archives=s3://${var.bucket}/venv/pysequila/pyspark_pysequila-${var.pysequila_version}.tar.gz#environment --jars s3://${var.bucket}/jars/sequila/${var.sequila_version}/* --conf spark.emr-serverless.driverEnv.PYSPARK_DRIVER_PYTHON=./environment/bin/python --conf spark.emr-serverless.driverEnv.PYSPARK_PYTHON=./environment/bin/python --conf spark.emr-serverless.executorEnv.PYSPARK_PYTHON=./environment/bin/python --conf spark.files=${join(",", var.data_files)}"
          }
      }'
    EOT
}