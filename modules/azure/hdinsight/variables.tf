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

variable "hdinsight_version" {
  type        = string
  description = "HDInsight version"
  default     = "5.0"
}