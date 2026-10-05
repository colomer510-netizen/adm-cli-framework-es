#!/bin/bash
# Descripción: Permite hacer una petición GET a una URL/API y ver la respuesta formateada
URL=$1
if [ -z "$URL" ]; then echo "Uso: adm dev test-api <url>"; exit 1; fi
curl -s "$URL" | (jq . 2>/dev/null || cat)
