resource "random_string" "unique_suffix" {
  length  = 7
  special = false
  upper   = false
}

# Définition du groupe de ressources dans Azure
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name   # Nom du groupe de ressources
  location = var.location              # Localisation du groupe de ressources
}

# Module pour configurer le réseau virtuel (VNet) et les sous-réseaux
module "network" {
  source               = "./modules/network"    # Chemin vers le module réseau
  vnet_name            = var.vnet_name          # Nom du réseau virtuel
  address_space        = var.address_space      # Espace d'adressage du réseau virtuel
  location             = var.location           # Localisation du réseau
  resource_group_name  = var.resource_group_name # Groupe de ressources associé
  subnet_name          = var.subnet_name        # Nom du sous-réseau
  subnet_address_prefixes = var.subnet_address_prefixes # Plages d'adresses du sous-réseau

  # Dépendance : ce module sera déployé après le groupe de ressources
  depends_on = [azurerm_resource_group.main]
}

# Module pour configurer un stockage Blob
module "blob_storage" {
  source               = "./modules/blob_storage" # Chemin vers le module de stockage Blob
  storage_account_name = "${var.storage_account_name}${random_string.unique_suffix.result}" # Nom du compte de stockage avec une partie aléatoire
  resource_group_name  = var.resource_group_name  # Groupe de ressources associé
  location             = var.location            # Localisation du stockage
  container_name       = var.container_name      # Nom du conteneur Blob

  # Dépendance : ce module sera déployé après le groupe de ressources
  depends_on = [azurerm_resource_group.main]
}

# Module pour configurer une base de données
module "database" {
  source               = "./modules/database"    # Chemin vers le module base de données
  server_name          = var.server_name         # Nom du serveur de base de données
  resource_group_name  = azurerm_resource_group.main.name # Groupe de ressources associé
  location             = azurerm_resource_group.main.location # Localisation
  admin_login          = var.admin_login         # Nom d'utilisateur admin pour la base de données
  admin_password       = var.admin_password      # Mot de passe admin
  sku_name             = var.sku_name            # Configuration SKU pour la base de données
  storage_mb           = var.storage_mb          # Taille de stockage (en Mo)
  subnet_id            = module.network.postgresql_subnet_id # ID du sous-réseau associé
  database_name        = var.database_name       # Nom de la base de données
  private_dns_zone_id  = module.network.private_dns_zone_id # Zone DNS privée associée
  name                 = "${var.name}${random_string.unique_suffix.result}"              # Nom de la ressource
}

# Module pour configurer un service applicatif
module "app_service" {
  source                 = "./modules/app_service"          # Chemin vers le module App Service
  app_service_plan_name  = var.app_service_plan_name        # Nom du plan App Service
  app_service_name       = "${var.app_service_name}${random_string.unique_suffix.result}"            # Nom du service applicatif
  location               = var.location                    # Localisation
  resource_group_name    = var.resource_group_name         # Groupe de ressources associé
  subnet_id              = module.network.app_service_subnet_id # ID du sous-réseau pour l'App Service

  # Dépendance : ce module sera déployé après le groupe de ressources
  depends_on             = [azurerm_resource_group.main]

  # Configuration Docker pour le service applicatif
  docker_image           = var.docker_image                # Image Docker
  docker_registry_password = var.docker_registry_password  # Mot de passe du registre Docker
  docker_registry_url    = var.docker_registry_url         # URL du registre Docker
  docker_registry_username = var.docker_registry_username  # Nom d'utilisateur du registre Docker

  # Configuration de l'intégration avec le stockage Blob
  storage_url        = module.blob_storage.storage_url     # URL du stockage
  storage_account_id = module.blob_storage.storage_account_id # ID du compte de stockage

  # Variables d'environnement pour la base de données
  database_host     = module.database.postgresql_host      # Hôte de la base de données
  database_port     = module.database.postgresql_port      # Port de la base de données
  database_name     = module.database.server_name          # Nom du serveur
  database_user     = var.admin_login                      # Nom d'utilisateur
  database_password = var.admin_password                   # Mot de passe

  # Configuration New Relic pour le monitoring
  new_relic_app_name = var.new_relic_app_name              # Nom de l'application dans New Relic
  new_relic_license_key = var.new_relic_license_key        # Clé de licence New Relic
}
