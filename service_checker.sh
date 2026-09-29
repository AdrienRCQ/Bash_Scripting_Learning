#!/bin/bash

# Vérification de la structure des paramètres :
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <nom du service>" >&2
    exit 2
fi

if [[ -z "$1" ]]; then
    echo "Erreur : Le nom du service ne peut pas être vide !!!"
    exit 2
fi

service="$1"
# Permet de valider les noms de service sans .service
if [[ "$service" != *.service ]]; then
    service = "${service}.service"
fi

# Récupérationde l'état de chargement
if ! load_state=$(systemctl show --property=LoadState --value -- "$service"); then
    echo "ERROR - Impossible d'interroger systemd pour $service" >&2
    exit 3
fi
case "$load_state" in
    loaded)
        # Le service est chargé : poursuivre le script
        ;;
    not-found)
        echo "ERROR - Le service $service est masqué : démarrage bloqué" >&2
        exit 3
        ;;
    *)
        echo "ERROR - Etat de chargement inattendu pour $service : $load_state" >&2
        exit 3
        ;;
esac

# Vérification si le service est actif ou non
if systemctl is-active --quiet -- "$service";then
    echo "OK - Le service $service est actif"
    exit 0
fi

echo "WARNING - Le service $service est inactif ou en état dégradé" >&2
echo "INFO - Tentative de relance du service $service..."

# Tenter la relance du service
if ! sudo systemctl restart -- "$service"; then
    echo "ERROR - La commande de relance du service $service a échoué" >&2
    exit 4
fi

# Vérification de l'état après relance
if systemctl is-active --quiet -- "$service";then
    echo "OK - Le service $service est actif après relance"
    exit 0
else
    echo "ERROR - Le service $service n'est pas actif après la relance" >&2
    exit 5
fi