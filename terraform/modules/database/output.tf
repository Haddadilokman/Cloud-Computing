output "server_name" {
  value       = azurerm_postgresql_flexible_server.postgresql_server.name
  description = "The name of the PostgreSQL Flexible Server."
}

output "database_name" {
  value       = azurerm_postgresql_flexible_server_database.postgresql_database.name
  description = "The name of the database created on the PostgreSQL Flexible Server."
}

output "postgresql_host" {
  value = azurerm_postgresql_flexible_server.postgresql_server.fqdn
}

output "postgresql_port" {
  value = 5432
}