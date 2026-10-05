#!/bin/bash
# Descripción: Extrae el audio (MP3) de un video

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

requerir_cmd "ffmpeg" "ffmpeg"

VIDEO=$1
if [ -z "$VIDEO" ]; then echo -e "${ROJO}Uso: adm media extraer-audio <video.mp4>${NC}"; exit 1; fi
SALIDA="${VIDEO%.*}.mp3"
ffmpeg -i "$VIDEO" -q:a 0 -map a "$SALIDA" && ok "Audio extraído en: $SALIDA"
