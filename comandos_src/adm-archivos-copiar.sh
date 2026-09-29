#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "❌ Uso correcto: adm-copiar <origen> <destino>"
    exit 1
fi
cp -r "$1" "$2"
echo "✅ Copiado exitosamente."
