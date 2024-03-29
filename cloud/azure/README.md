# azure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.30.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | ../../modules/azure/aks | n/a |
| <a name="module_azure-resources"></a> [azure-resources](#module\_azure-resources) | ../../modules/azure/resource-mgmt | n/a |
| <a name="module_azure-staging-blob"></a> [azure-staging-blob](#module\_azure-staging-blob) | ../../modules/azure/jobs-code | n/a |
| <a name="module_hdinsight"></a> [hdinsight](#module\_hdinsight) | ../../modules/azure/hdinsight | n/a |
| <a name="module_spark-on-k8s-operator-aks"></a> [spark-on-k8s-operator-aks](#module\_spark-on-k8s-operator-aks) | ../../modules/kubernetes/spark-on-k8s-operator | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure-aks-deploy"></a> [azure-aks-deploy](#input\_azure-aks-deploy) | Deploy AKS cluster | `bool` | `false` | no |
| <a name="input_azure-hdinsight-deploy"></a> [azure-hdinsight-deploy](#input\_azure-hdinsight-deploy) | Deploy HDInsight cluster | `bool` | `false` | no |
| <a name="input_data_files"></a> [data\_files](#input\_data\_files) | Data files to copy to staging bucket | `list(string)` | n/a | yes |
| <a name="input_hdinsight_gateway_password"></a> [hdinsight\_gateway\_password](#input\_hdinsight\_gateway\_password) | Hadoop gateway password (i.e. Ambari, YARN UI console, etc) | `string` | `null` | no |
| <a name="input_hdinsight_ssh_password"></a> [hdinsight\_ssh\_password](#input\_hdinsight\_ssh\_password) | SSH password to all nodes in the cluster | `string` | `null` | no |
| <a name="input_pysequila_image_aks"></a> [pysequila\_image\_aks](#input\_pysequila\_image\_aks) | AKS PySeQuiLa image | `string` | n/a | yes |
| <a name="input_pysequila_version"></a> [pysequila\_version](#input\_pysequila\_version) | PySeQuiLa version | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Location of the cluster | `string` | n/a | yes |
| <a name="input_sequila_version"></a> [sequila\_version](#input\_sequila\_version) | SeQuiLa version | `string` | n/a | yes |
| <a name="input_spark_version"></a> [spark\_version](#input\_spark\_version) | Apache Spark version | `string` | `"3.2.2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hdinsight_gateway_password"></a> [hdinsight\_gateway\_password](#output\_hdinsight\_gateway\_password) | n/a |
| <a name="output_hdinsight_ssh_password"></a> [hdinsight\_ssh\_password](#output\_hdinsight\_ssh\_password) | n/a |
| <a name="output_pysequila_submit_command"></a> [pysequila\_submit\_command](#output\_pysequila\_submit\_command) | n/a |
| <a name="output_ssh_command"></a> [ssh\_command](#output\_ssh\_command) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
