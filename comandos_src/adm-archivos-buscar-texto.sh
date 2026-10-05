#!/bin/bash
# Descripción: Busca un texto específico dentro de los archivos

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
if [ -z "$1" ]; then
    echo "Uso: adm archivos buscar-texto <palabra>"
    exit 1
fi
echo "🔍 Buscando el texto '$1' dentro de los archivos..."
grep -rnw . -e "$1"
