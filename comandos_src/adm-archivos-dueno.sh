#!/bin/bash
# Descripción: Cambia el propietario (chown) de un archivo
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Uso: adm archivos dueño <usuario> <archivo>"
    exit 1
fi
echo "👤 Cambiando dueño de '$2' a '$1'..."
sudo chown "$1" "$2"
