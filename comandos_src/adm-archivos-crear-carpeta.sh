#!/bin/bash
# Descripción: Crea un nuevo directorio/carpeta
if [ -z "$1" ]; then
    echo "❌ Uso correcto: adm-crear-carpeta <nombre_carpeta>"
    exit 1
fi
mkdir -p "$1"
echo "📁 Carpeta '$1' creada."
