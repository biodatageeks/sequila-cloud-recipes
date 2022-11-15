variable "region" {
  type        = string
  description = "Location of the cluster"
}

variable "resource_group" {
  type        = string
  description = "Azure resource group"
}

variable "storage_container_id" {
  type        = string
  description = "Azure storage container"
}

variable "storage_account_access_key" {
  type        = string
  description = "Storage account access key"
}

variable "storage_account_name" {
  type = string
}

variable "storage_container_name" {
  type = string
}

variable "hdinsight_version" {
  type        = string
  description = "HDInsight version"
  default     = "5.0"
}

variable "spark_version" {
  type        = string
  default     = "3.2.2"
  description = "Apache Spark version"
}

variable "pysequila_version" {
  type        = string
  description = "PySeQuiLa version"
}

variable "sequila_version" {
  type        = string
  description = "SeQuiLa version"
}

variable "gateway_password" {
  type = string
  #  sensitive   = true
  description = "Hadoop gateway password (i.e. Ambari, YARN UI console, etc)"
}

variable "node_ssh_password" {
  type = string
  #  sensitive   = true
  description = "SSH password to all nodes in the cluster"
}

variable "data_files" {
  type        = list(string)
  description = "Data files to copy to staging bucket"
}
