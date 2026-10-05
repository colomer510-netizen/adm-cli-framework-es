#!/bin/bash
# Descripción: Mueve o renombra un archivo o carpeta
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "❌ Uso correcto: adm-mover <origen> <destino>"
    exit 1
fi
mv "$1" "$2"
echo "✅ Movido exitosamente."
