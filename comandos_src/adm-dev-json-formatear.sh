#!/bin/bash
# Descripción: Formatea de forma legible (pretty-print) cualquier archivo JSON
ARCHIVO=$1
if [ -z "$ARCHIVO" ]; then echo "Uso: adm dev json-formatear <archivo.json>"; exit 1; fi
if command -v jq &> /dev/null; then
    jq . "$ARCHIVO"
else
    python3 -m json.tool "$ARCHIVO"
fi
