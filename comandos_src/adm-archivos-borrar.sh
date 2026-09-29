#!/bin/bash
if [ -z "$1" ]; then
    echo "❌ Uso correcto: adm-borrar <archivo_o_carpeta>"
    exit 1
fi
rm -rf "$1"
echo "🗑️ Elemento borrado."
