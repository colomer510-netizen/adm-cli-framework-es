#!/bin/bash
# Descripción: Descarga un archivo desde internet usando wget
if [ -z "$1" ]; then
    echo "Uso: adm red descargar <URL>"
    exit 1
fi
echo "⬇️ Descargando archivo desde $1..."
wget -c "$1"
