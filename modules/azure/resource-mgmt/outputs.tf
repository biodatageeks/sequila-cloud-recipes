output "resource_group" {
  value = azurerm_resource_group.sequila.name
}

output "storage_account" {
  value = azurerm_storage_account.sequila_account.name
}

output "azurerm_storage_container" {
  value = azurerm_storage_container.sequila.name
}