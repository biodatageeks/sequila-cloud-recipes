# jobs-code

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_object.sequila-data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.sequila-pileup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [local_file.deployment_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Bucket name for code, dependencies, etc. | `string` | n/a | yes |
| <a name="input_data_files"></a> [data\_files](#input\_data\_files) | Data files to copy to staging bucket | `list(string)` | n/a | yes |
| <a name="input_pysequila_image_eks"></a> [pysequila\_image\_eks](#input\_pysequila\_image\_eks) | EKS PySeQuiLa image | `string` | n/a | yes |
| <a name="input_pysequila_version"></a> [pysequila\_version](#input\_pysequila\_version) | PySeQuiLa version | `string` | n/a | yes |
| <a name="input_sequila_version"></a> [sequila\_version](#input\_sequila\_version) | SeQuiLa version | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
