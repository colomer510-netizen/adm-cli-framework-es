#!/bin/bash
# Descripción: Convierte una cadena de texto a formato seguro para URLs

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
TEXTO=$1
if [ -z "$TEXTO" ]; then echo 'Uso: adm dev url-encode "texto a codificar"'; exit 1; fi
python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$TEXTO"
