output "emr_server_exec_role_arn" {
  value       = try(module.emr-job[0].emr_server_exec_role_arn, "No EMR setup.")
  description = "ARN of EMR Serverless execution role"
}

output "emr_serverless_command" {
  value       = try(module.emr-job[0].emr_serverless_command, "No EMR setup.")
  description = "EMR Serverless command to run a sample SeQuiLa job"
}