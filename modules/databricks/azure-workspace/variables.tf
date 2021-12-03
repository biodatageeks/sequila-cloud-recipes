variable "region" {
  type        = string
  description = "Deployment region"
  default     = "westeurope"
}

variable "project_prefix" {
  type        = string
  description = "Prefix to use for naming resource group and workspace"
  default     = "demo"
}

variable "sku" {
  type        = string
  description = "The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial."
  default     = "trial"
}