#!/bin/bash

if ! command -v gh &> /dev/null; then
    # L'utilisation de "sudo" ici n'est pas bonne
    # Si on est dans un script automatique, ça va bloquer à la demande de mot de passe
    sudo apt update
    # On préfère utiliser "apt-get" en non-interactif, et "apt" en interactif
    sudo apt install gh -y
fi
if ! command -v jq &> /dev/null; then
    sudo apt update
    sudo apt install jq -y
fi

REPO_OWNER=$(echo "$GITHUB_REPOSITORY" | cut -d'/' -f1)
REPO_NAME=$(echo "$GITHUB_REPOSITORY" | cut -d'/' -f2)

# https://cli.github.com/manual/gh_issue_list
# On ne doit pas utilise "--limit 1000", car sinon ça fausse nos métriques si on a
# + de 1000 issues d'ouvertes / fermées, ça arrive vite
OPEN_ISSUES=$(gh issue list --state open --limit 1000 --json number | jq length)
CLOSED_ISSUES=$(gh issue list --state closed --limit 1000 --json number | jq length)

TOTAL_ISSUES=$((OPEN_ISSUES + CLOSED_ISSUES))

echo "Statistiques des Issues:"
echo "  - Issues ouvertes: $OPEN_ISSUES"
echo "  - Issues fermées: $CLOSED_ISSUES"
echo "  - Total: $TOTAL_ISSUES"

if [ $TOTAL_ISSUES -gt 0 ]; then
    RESOLUTION_RATE=$(( (CLOSED_ISSUES * 100) / TOTAL_ISSUES ))
    echo "  - Taux de résolution: $RESOLUTION_RATE%"
else
    echo "  - Aucune issue trouvée"
fi

# Dommage que l'on utilise pas le RESOLUTION RATE dans les conditions pour savoir
# l'état du projet
echo "Analyse:"
if [ $OPEN_ISSUES -gt $CLOSED_ISSUES ]; then
    echo "Plus d'issues ouvertes"
    echo "TRAVAILLER LES ISSUES SINON CE SERA LA MORT"
elif [ $CLOSED_ISSUES -gt $OPEN_ISSUES ]; then
    echo "Plus d'issues fermées"
    echo "PAS MAL MAIS CONTINUEZ A BOSSER"
else
    echo "Nombre égal d'issues ouvertes et fermées"
    echo "CHANGEZ MOI 9A §§§§§"
fi

echo "Issues ouvertes par label:"
# on regare les issues ouvertes et leur labels et on va utiliser jq pour chopper les noms des labels qu'on va ensuite trier les labels par apparition
# Bon début
gh issue list --state open --json labels | jq -r '.[].labels[].name' | sort| uniq -c | sort -nr
