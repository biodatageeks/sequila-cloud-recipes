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
  default     = "test"
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

variable "gcp-gke-deploy" {
  type    = bool
  default = false
}

variable "gke_max_node_count" {
  type    = number
  default = 3
}

variable "gke_machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "gke_preemptible" {
  type    = bool
  default = true
}

variable "volume_size" {
  type    = string
  default = "1Gi"
}

variable "azure-aks-deploy" {
  type    = bool
  default = false
}