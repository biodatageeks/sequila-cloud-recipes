# aws

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.38.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.38.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws-job-code"></a> [aws-job-code](#module\_aws-job-code) | ../../modules/aws/jobs-code | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | v18.30.2 |
| <a name="module_emr-job"></a> [emr-job](#module\_emr-job) | ../../modules/aws/emr-serverless | n/a |
| <a name="module_spark-on-k8s-operator-eks"></a> [spark-on-k8s-operator-eks](#module\_spark-on-k8s-operator-eks) | ../../modules/kubernetes/spark-on-k8s-operator | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ../../modules/aws/storage | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | v3.18.1 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/4.38.0/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.eks](https://registry.terraform.io/providers/hashicorp/aws/4.38.0/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws-eks-deploy"></a> [aws-eks-deploy](#input\_aws-eks-deploy) | Deploy EKS service | `bool` | `false` | no |
| <a name="input_aws-emr-deploy"></a> [aws-emr-deploy](#input\_aws-emr-deploy) | Deploy EMR service | `bool` | `false` | no |
| <a name="input_aws-emr-release"></a> [aws-emr-release](#input\_aws-emr-release) | EMR Serverless release (needs to be >=6.6.0) | `string` | n/a | yes |
| <a name="input_data_files"></a> [data\_files](#input\_data\_files) | Data files to copy to staging bucket | `list(string)` | n/a | yes |
| <a name="input_eks_machine_type"></a> [eks\_machine\_type](#input\_eks\_machine\_type) | Machine size | `string` | `"t3.xlarge"` | no |
| <a name="input_eks_max_node_count"></a> [eks\_max\_node\_count](#input\_eks\_max\_node\_count) | Maximum number of kubernetes nodes | `number` | `2` | no |
| <a name="input_eks_preemptible"></a> [eks\_preemptible](#input\_eks\_preemptible) | Enable preemtible(spot) instance in a Kubernetes pool | `bool` | `true` | no |
| <a name="input_pysequila_image_eks"></a> [pysequila\_image\_eks](#input\_pysequila\_image\_eks) | EKS PySeQuiLa image | `string` | n/a | yes |
| <a name="input_pysequila_version"></a> [pysequila\_version](#input\_pysequila\_version) | PySeQuiLa version | `string` | n/a | yes |
| <a name="input_sequila_version"></a> [sequila\_version](#input\_sequila\_version) | SeQuiLa version | `string` | n/a | yes |
| <a name="input_spark_version"></a> [spark\_version](#input\_spark\_version) | Apache Spark version | `string` | `"3.2.2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_emr_server_exec_role_arn"></a> [emr\_server\_exec\_role\_arn](#output\_emr\_server\_exec\_role\_arn) | ARN of EMR Serverless execution role |
| <a name="output_emr_serverless_command"></a> [emr\_serverless\_command](#output\_emr\_serverless\_command) | EMR Serverless command to run a sample SeQuiLa job |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
