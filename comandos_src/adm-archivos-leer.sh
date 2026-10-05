#!/bin/bash
# Descripción: Muestra el contenido de un archivo en la terminal
if [ -z "$1" ]; then
    echo "❌ Uso correcto: adm-leer <archivo>"
    exit 1
fi
cat "$1"
