#!/bin/bash
# Descripción: Cambia las dimensiones (ancho/alto) de una imagen

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "convert" "imagemagick"
ENTRADA=$1
RESOLUCION=$2
SALIDA=$3
if [ -z "$SALIDA" ]; then echo "Uso: adm media redimensionar <entrada.png> <1280x720> <salida.png>"; exit 1; fi
ffmpeg -i "$ENTRADA" -vf scale=$RESOLUCION "$SALIDA"
