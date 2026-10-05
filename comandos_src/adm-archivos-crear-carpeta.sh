#!/bin/bash
# Descripción: Crea un nuevo directorio/carpeta

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
if [ -z "$1" ]; then
    echo "❌ Uso correcto: adm-crear-carpeta <nombre_carpeta>"
    exit 1
fi
mkdir -p "$1"
echo "📁 Carpeta '$1' creada."
