output "server_name" {
  value = azurerm_postgresql_flexible_server.main.name
}

output "database_name" {
  value = azurerm_postgresql_flexible_server_database.main.name
}

