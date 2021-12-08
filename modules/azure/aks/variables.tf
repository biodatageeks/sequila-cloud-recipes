variable "region" {
  type        = string
  description = "Location of the cluster"
}

variable "resource_group" {
  type = string
}

variable "machine_type" {
  type        = string
  description = "Azure machine type"
  default     = "Standard_D2_v2"
}

variable "max_node_count" {
  type        = number
  description = "Maximum number of AKS nodes"
  default     = 2
}