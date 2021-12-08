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
