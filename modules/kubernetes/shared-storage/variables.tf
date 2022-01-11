variable "pvc-name" {}
variable "storage_account" {
  type    = string
  default = "test"
}

variable "bucket_name" {
  type    = string
  default = "data"
}
