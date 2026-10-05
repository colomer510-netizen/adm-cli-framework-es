#!/bin/bash
# Descripción: Cambia el propietario (chown) de un archivo

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Uso: adm archivos dueño <usuario> <archivo>"
    exit 1
fi
echo "👤 Cambiando dueño de '$2' a '$1'..."
sudo chown "$1" "$2"
