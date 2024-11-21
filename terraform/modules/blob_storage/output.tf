output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
  description = "The name of the Azure Storage Account."
}

output "container_name" {
  value = azurerm_storage_container.storage_container.name
  description = "The name of the Azure Storage Container."
}
