#!/bin/bash
# Descripción: Muestra el contenido de un archivo en la terminal

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
if [ -z "$1" ]; then
    echo "❌ Uso correcto: adm-leer <archivo>"
    exit 1
fi
cat "$1"
