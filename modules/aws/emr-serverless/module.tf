locals {
  resources_dir = "${path.module}/resources"
  jars_dir      = "${local.resources_dir}/dependencies"
}

resource "aws_emrserverless_application" "emr-serverless" {
  name          = "sequila"
  release_label = var.aws-emr-release
  type          = "spark"
  auto_stop_configuration {
    enabled              = true
    idle_timeout_minutes = 5
  }
  network_configuration {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

}

resource "aws_iam_role" "EMRServerlessS3RuntimeRole" {
  name = "sequila-role"

  tags = {
    Name = "sequila-role"
  }

  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Action = "sts:AssumeRole"
          Principal = {
            Service = "emr-serverless.amazonaws.com"
          }
          Effect = "Allow"
        }
      ]
    }
  )
}



data "external" "dependencies-extract" {
  program = ["${local.resources_dir}/jar_extractor.sh", var.pysequila_version, local.resources_dir, local.jars_dir]


}

resource "aws_s3_object" "sequila-deps" {
  for_each = toset(split(",", data.external.dependencies-extract.result.jars))
  key      = "jars/sequila/${var.sequila_version}/${each.key}"
  source   = "${local.jars_dir}/${each.key}"
  bucket   = var.bucket
  acl      = "public-read"
}

resource "null_resource" "pysequila-venv-pack" {
  provisioner "local-exec" {
    command = "${local.resources_dir}/venv_packer.sh ${var.pysequila_version} ${local.resources_dir}"
  }
}

resource "aws_s3_object" "pysequila-venv-pack" {
  depends_on = [null_resource.pysequila-venv-pack]
  key        = "venv/pysequila/pyspark_pysequila-${var.pysequila_version}.tar.gz"
  source     = "${local.resources_dir}/venv/pyspark_pysequila-${var.pysequila_version}.tar.gz"
  bucket     = var.bucket
  acl        = "public-read"
}
