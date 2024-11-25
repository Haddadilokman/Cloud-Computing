# Création d'un serveur PostgreSQL flexible dans Azure
resource "azurerm_postgresql_flexible_server" "postgresql_server" {
  name                = var.name                          # Nom du serveur PostgreSQL
  location            = var.location                      # Localisation
  resource_group_name = var.resource_group_name           # Groupe de ressources associé
  administrator_login = var.admin_login                   # Nom d'utilisateur administrateur pour PostgreSQL
  administrator_password = var.admin_password             # Mot de passe de l'administrateur
  sku_name            = var.sku_name                      # Configuration matérielle (SKU) du serveur (ex: GP_Standard_D2s_v3)
  storage_mb          = var.storage_mb                    # Taille du stockage alloué en Mo
  delegated_subnet_id = var.subnet_id                     # ID du sous-réseau dédié pour l'intégration réseau
  private_dns_zone_id = var.private_dns_zone_id           # ID de la zone DNS privée pour la résolution de noms
  version             = "13"                              # Version de PostgreSQL utilisée (13)

  public_network_access_enabled = false                   # Désactivation de l'accès réseau public pour plus de sécurité
}

# Création d'une base de données sur le serveur PostgreSQL flexible
resource "azurerm_postgresql_flexible_server_database" "postgresql_database" {
  name      = var.database_name                           # Nom de la base de données à créer
  server_id = azurerm_postgresql_flexible_server.postgresql_server.id # ID du serveur PostgreSQL où la base sera créée
  charset   = "UTF8"                                      # Jeu de caractères pour la base de données
  collation = "fr_FR.utf8"                                # Collation utilisée (français, UTF-8)
}
