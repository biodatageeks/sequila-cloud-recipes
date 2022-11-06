output "emr_server_exec_role_arn" {
  value       = try(module.emr-job.emr_server_exec_role_arn, "")
  description = "ARN of EMR Serverless execution role"
}

output "emr_serverless_command" {
  value       = try(module.emr-job.emr_serverless_command, "")
  description = "EMR Serverless command to run a sample SeQuiLa job"
}