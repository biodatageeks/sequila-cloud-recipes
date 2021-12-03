variable "project_name" {
  type        = string
  description = "Prefix to use for naming resource group and workspace"
}
variable "location" {
  type        = string
  description = "Location of the cluster"
}

variable "data_files" {
  type        = list(string)
  description = "Data files to copy to staging bucket"
}