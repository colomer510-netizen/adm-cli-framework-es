#!/bin/bash
# Descripción: Convierte imágenes entre formatos (ej. de PNG a JPG)
ENTRADA=$1
SALIDA=$2
if [ -z "$SALIDA" ]; then echo "Uso: adm media convertir-imagen <entrada.png> <salida.jpg>"; exit 1; fi
if command -v convert &> /dev/null; then
    convert "$ENTRADA" "$SALIDA"
else
    ffmpeg -i "$ENTRADA" "$SALIDA"
fi
