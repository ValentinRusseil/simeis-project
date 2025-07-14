#!/bin/sh

# Dans "workflows" on ne veut que des fichiers `yaml` de workflow, c'est bizarre d'y
# trouver un script.

echo "Starting Simeis server..."
if cargo run --release; then
    # Ce message ne va s'afficher qu'une fois le processus `simeis-server` terminé
    echo "Simeis server started successfully."
else
    echo "Failed to start Simeis server."
fi
