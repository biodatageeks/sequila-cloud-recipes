variable "azure-databricks-deploy" {
  type    = bool
  default = false
}
variable "azure-databricks-project_prefix" {
  type        = string
  description = "Prefix to use for naming resource group and workspace"
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
  type = string
}