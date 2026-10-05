#!/bin/bash
# Descripción: Reduce el peso de un archivo de video manteniendo buena calidad

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "ffmpeg" "ffmpeg"
ENTRADA=$1
SALIDA=$2
if [ -z "$SALIDA" ]; then echo "Uso: adm media comprimir-video <entrada.mp4> <salida.mp4>"; exit 1; fi
ffmpeg -i "$ENTRADA" -vcodec libx264 -crf 28 "$SALIDA"
