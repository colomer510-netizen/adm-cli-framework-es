#!/bin/bash
# Descripción: Comprime archivos o carpetas en un archivo .tar.gz
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Uso: adm archivos comprimir <archivo_salida.tar.gz> <carpeta_o_archivo>"
    exit 1
fi
echo "🗜️ Comprimiendo '$2' en '$1'..."
tar -czvf "$1" "$2"
