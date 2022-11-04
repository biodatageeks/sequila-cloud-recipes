# dataproc-workflow-template

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_dataproc_workflow_template.dataproc_workflow_template](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dataproc_workflow_template) | resource |
| [google_project_service.dataproc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.workflowexecution](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | n/a | `string` | n/a | yes |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | Dataproc version | `string` | `"2.0.27-ubuntu18"` | no |
| <a name="input_main_python_file_uri"></a> [main\_python\_file\_uri](#input\_main\_python\_file\_uri) | Main Python file uri | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the GCP project | `string` | n/a | yes |
| <a name="input_pysequila_version"></a> [pysequila\_version](#input\_pysequila\_version) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Location of the cluster | `string` | n/a | yes |
| <a name="input_sequila_version"></a> [sequila\_version](#input\_sequila\_version) | n/a | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone of the cluster | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
