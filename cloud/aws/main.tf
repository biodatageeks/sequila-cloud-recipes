module "storage" {
  source = "../../modules/aws/storage"
}


module "aws-job-code" {
  bucket              = module.storage.bucket
  source              = "../../modules/aws/jobs-code"
  data_files          = var.data_files
  pysequila_version   = var.pysequila_version
  sequila_version     = var.sequila_version
  pysequila_image_eks = var.pysequila_image_eks
}


module "vpc" {
  count   = (var.aws-eks-deploy || var.aws-emr-deploy) ? 1 : 0
  source  = "terraform-aws-modules/vpc/aws"
  version = "v3.18.1"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "emr-job" {
  count              = var.aws-emr-deploy ? 1 : 0
  source             = "../../modules/aws/emr-serverless"
  aws-emr-release    = var.aws-emr-release
  bucket             = module.storage.bucket
  spark_version      = var.spark_version
  pysequila_version  = var.pysequila_version
  sequila_version    = var.sequila_version
  data_files         = [for f in var.data_files : "s3://${module.storage.bucket}/data/${f}" if length(regexall("fasta", f)) > 0]
  subnet_ids         = module.vpc[0].private_subnets
  vpc_id             = module.vpc[0].vpc_id
  security_group_ids = [module.vpc[0].default_security_group_id]
}


module "eks" {
  count                           = var.aws-eks-deploy ? 1 : 0
  version                         = "v18.30.2"
  source                          = "terraform-aws-modules/eks/aws"
  cluster_name                    = "sequila"
  cluster_version                 = "1.23"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  subnet_ids                      = module.vpc[0].private_subnets
  vpc_id                          = module.vpc[0].vpc_id

  eks_managed_node_groups = {
    green = {
      min_size     = 1
      max_size     = var.eks_max_node_count
      desired_size = 1

      instance_types = [var.eks_machine_type]
      capacity_type  = var.eks_preemptible ? "SPOT" : "ON_DEMAND"
    }
  }
}

data "aws_eks_cluster_auth" "eks" {
  count = var.aws-eks-deploy ? 1 : 0
  name  = module.eks[0].cluster_id
}

data "aws_eks_cluster" "eks" {
  count = var.aws-eks-deploy ? 1 : 0
  name  = module.eks[0].cluster_id
}

provider "helm" {
  alias = "eks"
  kubernetes {
    host                   = try(data.aws_eks_cluster.eks[0].endpoint, "")
    token                  = try(data.aws_eks_cluster_auth.eks[0].token, "")
    cluster_ca_certificate = try(base64decode(data.aws_eks_cluster.eks[0].certificate_authority[0].data), "")
  }
}

module "spark-on-k8s-operator-eks" {
  depends_on = [module.eks]
  source     = "../../modules/kubernetes/spark-on-k8s-operator"
  image_tag  = "v1beta2-1.2.3-3.1.2-eks"
  count      = var.aws-eks-deploy ? 1 : 0
  providers = {
    helm = helm.eks
  }
}