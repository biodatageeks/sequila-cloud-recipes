# gcp

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.42.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp-dataproc-sequila-job"></a> [gcp-dataproc-sequila-job](#module\_gcp-dataproc-sequila-job) | ../../modules/gcp/dataproc-workflow-template | n/a |
| <a name="module_gcp-jobs-code"></a> [gcp-jobs-code](#module\_gcp-jobs-code) | ../../modules/gcp/jobs-code | n/a |
| <a name="module_gke"></a> [gke](#module\_gke) | ../../modules/gcp/gke | n/a |
| <a name="module_spark-on-k8s-operator-gke"></a> [spark-on-k8s-operator-gke](#module\_spark-on-k8s-operator-gke) | ../../modules/kubernetes/spark-on-k8s-operator | n/a |

## Resources

| Name | Type |
|------|------|
| [google_container_registry.registry](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/resources/container_registry) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/4.42.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data_files"></a> [data\_files](#input\_data\_files) | Data files to copy to staging bucket | `list(string)` | n/a | yes |
| <a name="input_gcp-dataproc-deploy"></a> [gcp-dataproc-deploy](#input\_gcp-dataproc-deploy) | Deploy Dataproc worflow template | `bool` | `false` | no |
| <a name="input_gcp-gke-deploy"></a> [gcp-gke-deploy](#input\_gcp-gke-deploy) | Deploy GKE cluster | `bool` | `false` | no |
| <a name="input_gke_machine_type"></a> [gke\_machine\_type](#input\_gke\_machine\_type) | Machine size | `string` | `"e2-standard-2"` | no |
| <a name="input_gke_max_node_count"></a> [gke\_max\_node\_count](#input\_gke\_max\_node\_count) | Maximum number of kubernetes nodes | `number` | `3` | no |
| <a name="input_gke_preemptible"></a> [gke\_preemptible](#input\_gke\_preemptible) | Enable preemtible(spot) instance in a Kubernetes pool | `bool` | `true` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Prefix to use for naming resource group and workspace | `string` | `"test"` | no |
| <a name="input_pysequila_image_gke"></a> [pysequila\_image\_gke](#input\_pysequila\_image\_gke) | GKE PySeQuiLa image | `string` | n/a | yes |
| <a name="input_pysequila_version"></a> [pysequila\_version](#input\_pysequila\_version) | PySeQuiLa version | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Location of the cluster | `string` | n/a | yes |
| <a name="input_sequila_version"></a> [sequila\_version](#input\_sequila\_version) | SeQuiLa version | `string` | n/a | yes |
| <a name="input_spark_version"></a> [spark\_version](#input\_spark\_version) | Apache Spark version | `string` | `"3.2.2"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone of the cluster | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
