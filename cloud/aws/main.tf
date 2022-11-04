module "aws-job-code" {
  source              = "../../modules/aws/jobs-code"
  data_files          = var.data_files
  pysequila_version   = var.pysequila_version
  sequila_version     = var.sequila_version
  pysequila_image_eks = var.pysequila_image_eks
}

resource "aws_ecr_repository" "ecr" {
  count                = var.aws-emr-deploy ? 1 : 0
  name                 = "ecr"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}