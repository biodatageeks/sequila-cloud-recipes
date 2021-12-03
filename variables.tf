variable "azure-databricks-deploy" {
  type    = bool
  default = false
}
variable "azure-databricks-project_prefix" {
  type        = string
  description = "Prefix to use for naming resource group and workspace"
  default     = "demo-sequila"
}

variable "azure-databricks-sku" {
  type        = string
  description = "The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial."
  default     = "trial"
}
variable "pysequila_version" {
  type = string
}
variable "sequila_version" {
  type = string
}
variable "spark_version" {
  type    = string
  default = "3.1.2"
}

variable "gcp-dataproc-deploy" {
  type    = bool
  default = false
}

variable "project_name" {
  type        = string
  description = "Prefix to use for naming resource group and workspace"
}
variable "location" {
  type        = string
  description = "Location of the cluster"
}

variable "zone" {
  type        = string
  description = "Zone of the cluster"
}

variable "data_files" {
  type        = list(string)
  description = "Data files to copy to staging bucket"
}