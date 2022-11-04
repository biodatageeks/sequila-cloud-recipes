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
variable "spark_version" {
  type        = string
  default     = "3.2.2"
  description = "Apache Spark version"
}

variable "pysequila_image_eks" {
  type        = string
  description = "EKS PySeQuiLa image"
}

variable "aws-emr-deploy" {
  type        = bool
  default     = false
  description = "Deploy EMR service"
}