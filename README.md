# Vpc-peering-apache-server
Création d'un Vpc peering avec installation d'un server Apache


# Projet Terraform pour VPC et Instances EC2

Ce projet Terraform crée une infrastructure AWS comprenant deux VPC, des sous-réseaux publics, des passerelles Internet, des tables de routage, des instances EC2 et une connexion de peering entre les VPC.

## Table des Matières

- [Description du Projet](#description-du-projet)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Configuration](#configuration)
- [Déploiement](#déploiement)
- [Notes Supplémentaires](#notes-supplémentaires)

## Description du Projet

Ce projet déploie une infrastructure AWS avec les composants suivants :
- Deux VPC (VPCA et VPCB) avec des plages CIDR distinctes.
- Des sous-réseaux publics dans chaque VPC.
- Des passerelles Internet associées à chaque VPC.
- Des tables de routage configurées pour permettre l'accès Internet.
- Des instances EC2 dans chaque sous-réseau avec un serveur Apache préinstallé.
- Une connexion de peering entre les deux VPC pour permettre la communication entre eux.

## Prérequis

Avant de déployer ce projet, assurez-vous que vous disposez des éléments suivants :
- Un compte AWS avec des autorisations appropriées pour créer des VPC, des sous-réseaux, des instances EC2, des groupes de sécurité, etc.
- [Terraform](https://www.terraform.io/downloads) installé sur votre machine locale.
- Une clé SSH configurée pour accéder aux instances EC2.

## Installation

1. Clonez ce dépôt :

    ```bash
    git clone <URL_DE_VOTRE_DEPOT>
    cd <NOM_DU_REPERTOIRE>
    ```

2. Configurez vos variables Terraform. Créez un fichier `terraform.tfvars` dans le répertoire racine et définissez les valeurs pour `key_name` :

    ```hcl
    key_name = "<NOM_DE_VOTRE_CLE_SSH>"
    ```

## Configuration

Les fichiers Terraform sont organisés comme suit :
- `main.tf` : Définit les VPC, sous-réseaux, passerelles Internet, tables de routage, et associations de tables de routage.
- `ec2.tf` : Définit les instances EC2 et les groupes de sécurité associés.
- `peer.tf` : Définit la connexion de peering entre les VPC et les routes de peering.
- `providers.tf` : Configure le fournisseur AWS et la version de Terraform.

## Déploiement

1. Initialisez le projet Terraform :

    ```bash
    terraform init
    ```

2. Vérifiez le plan de déploiement :

    ```bash
    terraform plan
    ```

3. Appliquez le plan pour créer l'infrastructure :

    ```bash
    terraform apply
    ```

   Confirmez l'application lorsque vous y êtes invité.

## Notes Supplémentaires

- Les instances EC2 sont configurées pour installer et exécuter un serveur Apache avec la configuration `user_data` fournie.
- Les VPC sont connectés via une connexion de peering, permettant la communication entre les deux VPC.
- Vous pouvez ajuster les configurations (CIDR, zones de disponibilité, type d'instance, etc.) en modifiant les fichiers Terraform correspondants.

Assurez-vous de surveiller les coûts associés à l'utilisation des ressources AWS et de les supprimer lorsque vous n'en avez plus besoin.
