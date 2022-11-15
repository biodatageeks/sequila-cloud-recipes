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

variable "aws-emr-release" {
  type        = string
  default     = "emr-6.6.0"
  description = "EMR Serverless release (needs to be >=6.6.0)"
}

variable "aws-eks-deploy" {
  type        = bool
  default     = false
  description = "Deploy EKS service"
}

variable "eks_max_node_count" {
  type        = number
  default     = 2
  description = "Maximum number of kubernetes nodes"
}

variable "eks_machine_type" {
  type        = string
  default     = "t3.xlarge"
  description = "Machine size"
}

variable "eks_preemptible" {
  type        = bool
  default     = true
  description = "Enable preemtible(spot) instance in a Kubernetes pool"
}
