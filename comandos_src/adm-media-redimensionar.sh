#!/bin/bash
# Descripción: Cambia las dimensiones (ancho/alto) de una imagen
ENTRADA=$1
RESOLUCION=$2
SALIDA=$3
if [ -z "$SALIDA" ]; then echo "Uso: adm media redimensionar <entrada.png> <1280x720> <salida.png>"; exit 1; fi
ffmpeg -i "$ENTRADA" -vf scale=$RESOLUCION "$SALIDA"
