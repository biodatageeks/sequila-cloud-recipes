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
  default = "3.2.2"
}

variable "pysequila_image_aks" {
  type = string
  description = "AKS PySeQuiLa image"
}


variable "region" {
  type        = string
  description = "Location of the cluster"
  default     = "test_region"
}

variable "zone" {
  type        = string
  description = "Zone of the cluster"
  default     = "test_zone"
}

variable "data_files" {
  type        = list(string)
  description = "Data files to copy to staging bucket"
}

variable "volume_size" {
  type    = string
  default = "1Gi"
}

variable "azure-aks-deploy" {
  type    = bool
  default = false
}