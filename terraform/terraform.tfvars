subscription_id = ""
resource_group_name    = "cloud-computing"
location               = "France Central"
vnet_name              = "cc-vnet"
address_space          = ["10.0.0.0/16"]
subnet_name            = "subnet"
subnet_address_prefixes = ["10.0.1.0/24"]

storage_account_name   = "ccprojectblobstorage"
container_name         = "blobcontainer"

server_name            = "cc-database"
admin_login            = "psqladmin"
admin_password         = "P@ssw0rd1234"
sku_name               = "B_Standard_B1ms"
storage_mb             = 32768
database_name          = "mydatabase"
name                   = "psql-server"

app_service_plan_name  = "cc-appserviceplan"
app_service_name       = "cc-appservice"
