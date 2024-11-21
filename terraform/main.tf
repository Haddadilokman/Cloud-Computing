resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source               = "./modules/network"
  vnet_name            = var.vnet_name
  address_space        = var.address_space
  location             = var.location
  resource_group_name  = var.resource_group_name
  subnet_name          = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
}

module "blob_storage" {
  source               = "./modules/blob_storage"
  storage_account_name = var.storage_account_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  container_name       = var.container_name
}

module "database" {
  source               = "./modules/database"
  server_name          = var.server_name
  resource_group_name  = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  admin_login          = var.admin_login
  admin_password       = var.admin_password
  sku_name             = var.sku_name
  storage_mb           = var.storage_mb
  subnet_id            = module.network.postgresql_subnet_id
  database_name        = var.database_name
  private_dns_zone_id  = module.network.private_dns_zone_id
  name                 = var.name
}

module "app_service" {
  source                 = "./modules/app_service"
  app_service_plan_name  = var.app_service_plan_name
  app_service_name       = var.app_service_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  subnet_id              = module.network.app_service_subnet_id
}
