#!/bin/bash
# Descripción: Crea un archivo de texto vacío

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
if [ -z "$1" ]; then
    echo "❌ Uso correcto: adm-crear-archivo <nombre_archivo>"
    exit 1
fi
touch "$1"
echo "📄 Archivo '$1' creado."
