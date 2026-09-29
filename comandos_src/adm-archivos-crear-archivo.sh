#!/bin/bash
if [ -z "$1" ]; then
    echo "❌ Uso correcto: adm-crear-archivo <nombre_archivo>"
    exit 1
fi
touch "$1"
echo "📄 Archivo '$1' creado."
