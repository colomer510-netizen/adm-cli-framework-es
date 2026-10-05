#!/bin/bash
# Descripción: Copia archivos de un lugar a otro
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "❌ Uso correcto: adm-copiar <origen> <destino>"
    exit 1
fi
cp -r "$1" "$2"
echo "✅ Copiado exitosamente."
