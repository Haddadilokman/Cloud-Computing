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

# Groupes

Le groupe est composé de 3 personnes : 
- DEMEULIER Theophile
- DEGAIN Aurélien
- HADDADI Lokman 
