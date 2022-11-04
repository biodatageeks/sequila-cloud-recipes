variable "region" {
  type        = string
  description = "Location of the cluster"
}

variable "data_files" {
  type        = list(string)
  description = "Data files to copy to staging bucket"
}

variable "storage_account" {
  type = string
}

variable "storage_container" {
  type = string
}

variable "pysequila_version" {
  type        = string
  description = "PySeQuiLa version"
}

variable "sequila_version" {
  type        = string
  description = "SeQuiLa version"
}

variable "pysequila_image_aks" {
  type        = string
  description = "AKS PySeQuiLa image"
}