variable "volume_size_gb" {
  description = "Size of data volume"
}
variable "storage_class" {
  type    = string
  default = "default"
}

variable "project_name" {
  type        = string
  description = "Name of the GCP project"
}

variable "zone" {
  type        = string
  description = "GCP zone"
}