variable "project_name" {
  type        = string
  description = "Prefix to use for naming resource group and workspace"
}
variable "region" {
  type        = string
  description = "Location of the cluster"
}

variable "data_files" {
  type        = list(string)
  description = "Data files to copy to staging bucket"
}


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