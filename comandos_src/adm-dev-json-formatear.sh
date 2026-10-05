#!/bin/bash
# Descripción: Formatea de forma legible (pretty-print) cualquier archivo JSON

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "jq" "jq"
ARCHIVO=$1
if [ -z "$ARCHIVO" ]; then echo "Uso: adm dev json-formatear <archivo.json>"; exit 1; fi
if command -v jq &> /dev/null; then
    jq . "$ARCHIVO"
else
    python3 -m json.tool "$ARCHIVO"
fi
