#!/bin/bash
# Descripción: Busca procesos activos por nombre

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
if [ -z "$1" ]; then
    echo "Uso: adm procesos buscar <nombre>"
    exit 1
fi
echo "🔍 Buscando procesos con nombre '$1'..."
pgrep -l -i "$1" || echo "No se encontraron procesos con ese nombre."
