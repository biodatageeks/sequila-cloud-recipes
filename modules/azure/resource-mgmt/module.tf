data "azurerm_subscription" "current" {

}

resource "azurerm_resource_group" "sequila" {
  name     = "sequila-resources"
  location = var.region
}

resource "random_string" "storage_id" {
  keepers = {
    sub_id = data.azurerm_subscription.current.id
  }
  length  = 8
  special = false
  lower   = true
}
#tfsec:ignore:azure-storage-default-action-deny
#tfsec:ignore:azure-storage-enforce-https
#tfsec:ignore:azure-storage-use-secure-tls-policy
resource "azurerm_storage_account" "sequila_account" {
  #checkov:skip=CKV_AZURE_33: "Ensure Storage logging is enabled for Queue service for read, write and delete requests"
  #checkov:skip=CKV_AZURE_59: "Ensure that Storage accounts disallow public access"
  #checkov:skip=CKV_AZURE_43: "Ensure the Storage Account naming rules"
  #checkov:skip=CKV_AZURE_60: "Ensure that storage account enables secure transfer"
  #checkov:skip=CKV_AZURE_35: "Ensure default network access rule for Storage Accounts is set to deny"
  #checkov:skip=CKV_AZURE_44: "Ensure Storage Account is using the latest version of TLS encryption"
  #checkov:skip=CKV_AZURE_3: "Ensure that 'Secure transfer required' is set to 'Enabled'"
  #checkov:skip=CKV_AZURE_34: "Ensure that 'Public access level' is set to Private for blob containers"
  name                            = "sequila${lower(random_string.storage_id.id)}"
  resource_group_name             = azurerm_resource_group.sequila.name
  location                        = azurerm_resource_group.sequila.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = true
  enable_https_traffic_only       = false
}
#tfsec:ignore:azure-storage-container-activity-logs-not-public
resource "azurerm_storage_container" "sequila" {
  #checkov:skip=CKV_AZURE_34: "Ensure that 'Public access level' is set to Private for blob containers"
  name                  = "sequila"
  storage_account_name  = azurerm_storage_account.sequila_account.name
  container_access_type = "container"
}