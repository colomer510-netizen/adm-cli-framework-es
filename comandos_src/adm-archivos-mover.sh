#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "❌ Uso correcto: adm-mover <origen> <destino>"
    exit 1
fi
mv "$1" "$2"
echo "✅ Movido exitosamente."
