# Bash Scripting Learning
Dans repository je vais centraliser l'ensemble des script bash que j'ai mis en place pour monter en compétence sur le sujet.

## installed_app.sh
Ce script permet de lister les application installé sur la machine selon les 3 types d'installation :
- apt
- snap
- flatpak

Le résultat est dans un fichier 'softwares.txt'

## machine_infos.sh
Récupération des informations classique de la machine.

## service_checker.sh
Script permettant de vérifier si le service spécifié en paramètre est actif.
Usage: ./service_checker.sh <nom du service>

## package_cleaner.sh
Script de nettoyage des packages APT ainsi que mise à jour.

## docker_actions.sh
Boite à outils pour interagir avec docker.
- Lister si des fichiers Dockerfile sont présents dans le répertoire actuel ;
- Lister les images docker disponible ;
- build l'image présente dans le répertoire ;