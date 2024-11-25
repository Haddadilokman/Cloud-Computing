# Définition du plan App Service dans Azure
resource "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name # Nom du plan App Service
  location            = var.location              # Localisation du plan
  resource_group_name = var.resource_group_name   # Groupe de ressources associé
  os_type             = "Linux"                   # Type de système d'exploitation (Linux)
  sku_name            = "B1"                      # SKU (Basic Tier, taille 1)
}

# Définition d'une application web Linux utilisant un plan App Service
resource "azurerm_linux_web_app" "app_service" {
  name                = var.app_service_name       # Nom de l'application web
  location            = var.location               # Localisation
  resource_group_name = var.resource_group_name    # Groupe de ressources associé
  service_plan_id     = azurerm_service_plan.app_service_plan.id # ID du plan App Service associé

  # Configuration de la pile applicative (stack)
  site_config {
    application_stack {
      docker_registry_url      = var.docker_registry_url       # URL du registre Docker
      docker_image_name        = var.docker_image             # Nom de l'image Docker
      docker_registry_password = var.docker_registry_password # Mot de passe du registre Docker
      docker_registry_username = var.docker_registry_username # Nom d'utilisateur du registre Docker
    }
  }

  # Variables d'environnement pour l'application
  app_settings = {
    # Configuration de la base de données
    DATABASE_HOST     = var.database_host          # Hôte de la base de données
    DATABASE_PORT     = var.database_port          # Port de la base de données
    DATABASE_NAME     = var.database_name          # Nom de la base de données
    DATABASE_USER     = var.database_user          # Nom d'utilisateur pour la base
    DATABASE_PASSWORD = var.database_password      # Mot de passe pour la base

    # Configuration pour le monitoring New Relic
    NEW_RELIC_LICENSE_KEY = var.new_relic_license_key # Clé de licence New Relic
    NEW_RELIC_APP_NAME    = var.new_relic_app_name    # Nom de l'application dans New Relic

    # Configuration pour l'accès au stockage
    STORAGE_ACCOUNT_URL = var.storage_url           # URL du compte de stockage
  }

  # Activation de l'identité managée (Managed Identity) pour l'application
  identity {
    type = "SystemAssigned" # Type d'identité : assignée par le système
  }
}

# Connexion de l'application web au sous-réseau via VNet Integration
resource "azurerm_app_service_virtual_network_swift_connection" "vnet_connection" {
  app_service_id = azurerm_linux_web_app.app_service.id # ID de l'application web
  subnet_id      = var.subnet_id                       # ID du sous-réseau auquel se connecter
}

# Attribution d'un rôle à l'application pour l'accès au stockage
resource "azurerm_role_assignment" "app_service_storage_access" {
  principal_id         = azurerm_linux_web_app.app_service.identity[0].principal_id # ID principal de l'identité managée
  role_definition_name = "Storage Blob Data Contributor" # Nom du rôle permettant l'accès aux Blobs
  scope                = var.storage_account_id         # Portée : le compte de stockage cible
}
