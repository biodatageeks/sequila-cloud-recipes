output "hdinsight_gateway_password" {
  value = try(module.hdinsight[0].hdinsight_gateway_password, "No HDInsight setup.")
}

output "hdinsight_ssh_password" {
  value = try(module.hdinsight[0].hdinsight_ssh_password, "No HDInsight setup.")
}

output "ssh_command" {
  value = try(module.hdinsight[0].ssh_command, "No HDInsight setup.")
}

output "pysequila_submit_command" {
  value = try(module.hdinsight[0].pysequila_submit_command, "No HDInsight setup.")
}