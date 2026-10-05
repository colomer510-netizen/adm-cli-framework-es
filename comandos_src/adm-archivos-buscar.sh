#!/bin/bash
# Descripción: Busca archivos por su nombre en el directorio actual

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
if [ -z "$1" ]; then
    echo "Uso: adm archivos buscar <nombre_archivo>"
    exit 1
fi
echo "🔍 Buscando archivos que contengan '$1'..."
find . -iname "*$1*"
