#!/bin/bash
# Descripción: Descarga un archivo desde internet usando wget

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
if [ -z "$1" ]; then
    echo "Uso: adm red descargar <URL>"
    exit 1
fi
echo "⬇️ Descargando archivo desde $1..."
wget -c "$1"
