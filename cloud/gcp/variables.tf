variable "pysequila_version" {
  type = string
  description = "PySeQuiLa version"
}
variable "sequila_version" {
  type = string
  description = "SeQuiLa version"
}

variable "pysequila_image_gke" {
  type = string
  description = "GKE PySeQuiLa image"
}

variable "spark_version" {
  type    = string
  default = "3.2.2"
  description = "Apache Spark version"
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
  default = "1"
}