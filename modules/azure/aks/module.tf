#tfsec:ignore:azure-container-limit-authorized-ips
#tfsec:ignore:azure-container-logging
#tfsec:ignore:azure-container-use-rbac-permissions
resource "azurerm_kubernetes_cluster" "sequila" {
  #checkov:skip=CKV_AZURE_115: "Ensure that AKS enables private clusters"
  #checkov:skip=CKV_AZURE_117: "Ensure that AKS uses disk encryption set"
  #checkov:skip=CKV_AZURE_7: "Ensure AKS cluster has Network Policy configured"
  #checkov:skip=CKV_AZURE_116: "Ensure that AKS uses Azure Policies Add-on"
  #checkov:skip=CKV_AZURE_6: "Ensure AKS has an API Server Authorized IP Ranges enabled"
  #checkov:skip=CKV_AZURE_4: "Ensure AKS logging to Azure Monitoring is Configured"
  #checkov:skip=CKV_AZURE_5: "Ensure RBAC is enabled on AKS clusters"
  name                = "sequila-aks1"
  location            = var.region
  resource_group_name = var.resource_group
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = var.max_node_count
    vm_size    = var.machine_type
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

