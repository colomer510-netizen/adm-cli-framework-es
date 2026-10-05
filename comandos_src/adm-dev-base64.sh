#!/bin/bash
# Descripción: Codifica un texto proporcionado en formato Base64

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
TEXTO=${1}
if [ -z "$TEXTO" ]; then echo -e "\033[0;31mUso: adm dev base64 "texto a codificar"\033[0m"; exit 1; fi
echo -e "\033[0;32mTexto en Base64:\033[0m"
echo -n "$TEXTO" | base64
