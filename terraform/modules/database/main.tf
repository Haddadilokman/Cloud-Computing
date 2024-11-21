resource "azurerm_postgresql_flexible_server" "postgresql_server" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  administrator_login = var.admin_login
  administrator_password = var.admin_password
  sku_name            = var.sku_name
  storage_mb          = var.storage_mb
  delegated_subnet_id = var.subnet_id
  private_dns_zone_id = var.private_dns_zone_id
  version             = "13"

  public_network_access_enabled = false
}

resource "azurerm_postgresql_flexible_server_database" "postgresql_database" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.postgresql_server.id
  charset   = "UTF8"
  collation = "fr_FR.utf8"
}
