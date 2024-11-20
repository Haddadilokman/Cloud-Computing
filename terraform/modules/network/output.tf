output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.postgresql.id
}

output "app_service_subnet_id" {
  value = azurerm_subnet.app_service.id
}

output "postgresql_subnet_id" {
  value = azurerm_subnet.postgresql.id
}
