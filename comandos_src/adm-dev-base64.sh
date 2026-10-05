#!/bin/bash
# Descripción: Codifica un texto proporcionado en formato Base64
TEXTO=${1}
if [ -z "$TEXTO" ]; then echo -e "\033[0;31mUso: adm dev base64 "texto a codificar"\033[0m"; exit 1; fi
echo -e "\033[0;32mTexto en Base64:\033[0m"
echo -n "$TEXTO" | base64
