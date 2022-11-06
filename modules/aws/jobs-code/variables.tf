variable "bucket" {
  type        = string
  description = "Bucket name for code, dependencies, etc."
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

variable "pysequila_image_eks" {
  type        = string
  description = "EKS PySeQuiLa image"
}