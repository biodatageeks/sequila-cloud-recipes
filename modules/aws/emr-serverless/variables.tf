variable "bucket" {
  type        = string
  description = "Bucket name for code, dependencies, etc."
}

variable "pysequila_version" {
  type        = string
  description = "PySeQuiLa version"
}

variable "sequila_version" {
  type        = string
  description = "SeQuiLa version"
}

variable "data_files" {
  type        = list(string)
  description = "Data files to copy to staging bucket"
}

variable "aws-emr-release" {
  type        = string
  description = "EMR Serverless release (needs to be >=6.6.0)"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets"
}

variable "vpc_id" {
  type        = string
  description = "VPC"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Default security group ids"
}