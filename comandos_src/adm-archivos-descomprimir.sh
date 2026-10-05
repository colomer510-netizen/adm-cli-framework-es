#!/bin/bash
# Descripción: Extrae el contenido de un archivo .tar.gz
if [ -z "$1" ]; then
    echo "Uso: adm archivos descomprimir <archivo.tar.gz_o_zip>"
    exit 1
fi
echo "📦 Descomprimiendo '$1'..."
if [[ "$1" == *.tar.gz || "$1" == *.tgz ]]; then
    tar -xzvf "$1"
elif [[ "$1" == *.zip ]]; then
    unzip "$1"
else
    echo "Formato no soportado (usa zip o tar.gz)."
fi
