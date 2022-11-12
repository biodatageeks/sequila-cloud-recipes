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

variable "pysequila_image_aks" {
  type        = string
  description = "AKS PySeQuiLa image"
}


variable "region" {
  type        = string
  description = "Location of the cluster"
}

variable "data_files" {
  type        = list(string)
  description = "Data files to copy to staging bucket"
}

variable "azure-aks-deploy" {
  type        = bool
  default     = false
  description = "Deploy AKS cluster"
}

variable "azure-hdinsight-deploy" {
  type        = bool
  default     = false
  description = "Deploy HDInsight cluster"
}