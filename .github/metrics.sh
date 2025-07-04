#!/bin/bash

if ! command -v gh &> /dev/null; then
    sudo apt update
    sudo apt install gh -y
fi
if ! command -v jq &> /dev/null; then
    sudo apt update
    sudo apt install jq -y
fi

REPO_OWNER=$(echo "$GITHUB_REPOSITORY" | cut -d'/' -f1)
REPO_NAME=$(echo "$GITHUB_REPOSITORY" | cut -d'/' -f2)

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
gh issue list --state open --json labels | jq -r '.[].labels[].name' | sort| uniq -c | sort -nr
