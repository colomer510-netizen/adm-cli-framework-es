#!/bin/bash
# Descripción: Busca archivos por su nombre en el directorio actual
if [ -z "$1" ]; then
    echo "Uso: adm archivos buscar <nombre_archivo>"
    exit 1
fi
echo "🔍 Buscando archivos que contengan '$1'..."
find . -iname "*$1*"
