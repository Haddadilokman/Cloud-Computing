# Cloud Computing - Énoncé projet

# Énoncé

Ce projet se basera sur la même API HTTP que la semaine 3 (07/10/2024) : [fhuitelec/junia-isen-examples-api](https://github.com/fhuitelec/junia-isen-examples-api).

Le but de ce projet est de :

- provisionner l’infrastructure de l’API sur Azure :
    - Azure App Service
    - Azure Database
    - Azure Blob storage
    - et toutes autre ressources pertinentes (virtual network, IAM, etc.)
- créer un environnement d’intégration et déploiement continu (CI/CD) avec GitHub Actions :
    - à la création d’une pull request sur le dépôt de l’application
        - faire tourner les tests
    - au merge d’une pull request sur `main` :
        - faire tourner les tests
        - créer et publier une image docker
        - déployer cette nouvelle image docker sur l’App Service

# Groupe :

Le groupe est composé de 3 personnes : 
- DEMEULIER Theophile
- DEGAIN Aurélien
- HADDADI Lokman 

# Architecture du projet: 

L’infrastructure terraform à été divisé en plusieurs modules: 
- un module app_service: Permet de déployer et de configurer les services d'application
- un module blob storage : Gère la création et la configuration des comptes de stockage blob.
- un module database : Ce module est responsable de la création et de la configuration des bases de données PostgreSQL.
- un module network : Gère la configuration du réseau, y compris les réseaux virtuels (VNet)

# Déploiement du projet : 

Il faut créer un fichier terraform.tfvars et y renseigner les informations suivantes, en se basant sur le template dans le fichiers terraform.tfvars.template :

## Identifiant unique de l'abonnement Azure
subscription_id = ""

## Nom d'utilisateur administrateur pour la base de données
admin_login            = ""

## Mot de passe administrateur pour la base de données
admin_password         = ""

## Clé de licence pour New Relic
new_relic_license_key = ""

## Mot de passe pour le registre Docker
docker_registry_password = ""

## Nom d'utilisateur pour le registre Docker
docker_registry_username = ""


Ensuite terraform peut être déployé via les commandes terraform init , terraform plan et ensuite terraform apply. 

