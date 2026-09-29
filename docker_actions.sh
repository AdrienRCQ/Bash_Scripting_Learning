#!/bin/bash

function build_image() {
    local tag_name="$1"

    if [ -z "$tag_name" ]; then
      echo "Erreur : tag_name manquant"
      return 1
    fi
    echo "Build de l'image $tag_name en cours"
    sudo docker build -t "$tag_name" .

    if [$? -eq 0]; then
      echo "Build terminé avec succès"
    else
      echo "Echec du build"
      return 1
    fi
}

function list_images() {
  echo "Images Docker locales :"
  sudo docker images
}

function list_dockerfiles() {
  echo "Dockerfiles dans le dossier courant :"
  ls Dockerfile* 2>/dev/null || echo "Aucun Dockerfile trouvé"
}



# =====================
# Parsing des options
# =====================

if [ "$#" -eq 0 ]; then
  usage
  exit 0
fi

while getopts ":b:idh" opt; do
  case "$opt" in
    b)
      ACTION_BUILD=true
      TAG_NAME="$OPTARG"
      ;;
    i)
      ACTION_IMAGES=true
      ;;
    d)
      ACTION_DOCKERFILES=true
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      echo "❌ Option invalide: -$OPTARG"
      usage
      exit 1
      ;;
    :)
      echo "❌ L'option -$OPTARG requiert un argument"
      exit 1
      ;;
  esac
done

# =====================
# Execution des actions
# =====================

[ "${ACTION_BUILD:-false}" = true ] && build_image "$TAG_NAME"
[ "${ACTION_IMAGES:-false}" = true ] && list_images
[ "${ACTION_DOCKERFILES:-false}" = true ] && list_dockerfiles