# emr

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_external"></a> [external](#provider\_external) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_emrserverless_application.emr-serverless](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/emrserverless_application) | resource |
| [aws_iam_role.EMRServerlessS3RuntimeRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_s3_object.pysequila-venv-pack](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.sequila-deps](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [null_resource.pysequila-venv-pack](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [external_external.dependencies-extract](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws-emr-release"></a> [aws-emr-release](#input\_aws-emr-release) | EMR Serverless release (needs to be >=6.6.0) | `string` | n/a | yes |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Bucket name for code, dependencies, etc. | `string` | n/a | yes |
| <a name="input_data_files"></a> [data\_files](#input\_data\_files) | Data files to copy to staging bucket | `list(string)` | n/a | yes |
| <a name="input_pysequila_version"></a> [pysequila\_version](#input\_pysequila\_version) | PySeQuiLa version | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Default security group ids | `list(string)` | n/a | yes |
| <a name="input_sequila_version"></a> [sequila\_version](#input\_sequila\_version) | SeQuiLa version | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnets | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_emr_server_exec_role_arn"></a> [emr\_server\_exec\_role\_arn](#output\_emr\_server\_exec\_role\_arn) | ARN of EMR Serverless execution role |
| <a name="output_emr_serverless_command"></a> [emr\_serverless\_command](#output\_emr\_serverless\_command) | EMR Serverless command to run a sample SeQuiLa job |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
