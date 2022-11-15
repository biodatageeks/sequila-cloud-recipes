output "resource_group" {
  value = azurerm_resource_group.sequila.name
}

output "storage_account" {
  value = azurerm_storage_account.sequila_account.name
}

output "storage_account_id" {
  value = azurerm_storage_account.sequila_account.id
}

output "storage_container_id" {
  value = azurerm_storage_container.sequila.id
}

output "storage_account_access_key" {
  value = azurerm_storage_account.sequila_account.primary_access_key
}

output "azurerm_storage_container" {
  value = azurerm_storage_container.sequila.name
}