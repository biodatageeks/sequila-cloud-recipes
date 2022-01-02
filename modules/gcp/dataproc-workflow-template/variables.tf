variable "project_name" {
  type        = string
  description = "Name of the GCP project"
}

variable "region" {
  type        = string
  description = "Location of the cluster"
}

variable "zone" {
  type        = string
  description = "Zone of the cluster"
}


variable "image_version" {
  type        = string
  description = "Dataproc version"
  default     = "2.0.24-ubuntu18"
}

variable "main_python_file_uri" {
  type        = string
  description = "Main Python file uri"
}

variable "pysequila_version" {
  type = string
}

variable "sequila_version" {
  type = string
}

variable "bucket_name" {
  type = string
}

