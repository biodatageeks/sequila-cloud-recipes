variable "pysequila_version" {
  type        = string
  description = "PySeQuiLa version"
}
variable "sequila_version" {
  type        = string
  description = "SeQuiLa version"
}

variable "pysequila_image_gke" {
  type        = string
  description = "GKE PySeQuiLa image"
}

variable "spark_version" {
  type        = string
  default     = "3.2.2"
  description = "Apache Spark version"
}

variable "gcp-dataproc-deploy" {
  type        = bool
  default     = false
  description = "Deploy Dataproc worflow template"
}

variable "project_name" {
  type        = string
  description = "Prefix to use for naming resource group and workspace"
  default     = "test"
}
variable "region" {
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

variable "gcp-gke-deploy" {
  type        = bool
  default     = false
  description = "Deploy GKE cluster"
}

variable "gke_max_node_count" {
  type        = number
  default     = 3
  description = "Maximum number of kubernetes nodes"
}

variable "gke_machine_type" {
  type        = string
  default     = "e2-standard-2"
  description = "Machine size"
}

variable "gke_preemptible" {
  type        = bool
  default     = true
  description = "Enable preemtible(spot) instance in a Kubernetes pool"
}