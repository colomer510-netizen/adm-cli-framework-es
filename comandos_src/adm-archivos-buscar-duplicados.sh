#!/bin/bash
# Descripción: Encuentra archivos duplicados en el directorio actual (basado en hash)
echo -e "\033[0;34mBuscando archivos duplicados (esto puede tardar)...\033[0m"
find . -type f -exec md5sum {} + | sort | uniq -d -w 32
echo "Si no aparece nada, no hay duplicados exactos."
