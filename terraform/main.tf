resource "azurerm_resource_group" "main" {
  name     = "cloud-computing"
  location = "France Central"
}

module "network" {
  source               = "./modules/network"
  vnet_name            = "cc-vnet"
  address_space        = ["10.0.0.0/16"]
  location             = "France Central"
  resource_group_name  = "cloud-computing"
  subnet_name          = "subnet"
  subnet_address_prefixes = ["10.0.1.0/24"]
}

module "blob_storage" {
  source               = "./modules/blob_storage"
  storage_account_name = "ccblobstorage"
  resource_group_name  = "cloud-computing"
  location             = "France Central"
  container_name       = "blobcontainer"
}

module "database" {
  source               = "./modules/database"
  server_name          = "cc-database"
  resource_group_name  = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  admin_login          = "psqladmin"
  admin_password       = "P@ssw0rd1234"
  sku_name             = "B_Standard_B1ms"
  storage_mb           = 32768
  subnet_id            = module.network.postgresql_subnet_id
  database_name        = "mydatabase"
  private_dns_zone_id  = module.network.private_dns_zone_id
  name                 = "psql-server"
  storage_tier         = "P4"
}

module "app_service" {
  source                 = "./modules/app_service"
  app_service_plan_name  = "cc-appserviceplan"
  app_service_name       = "cc-appservice"
  location               = "France Central"
  resource_group_name    = "cloud-computing"
  subnet_id              = module.network.app_service_subnet_id

}

