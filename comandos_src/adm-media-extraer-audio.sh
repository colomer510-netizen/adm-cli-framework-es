#!/bin/bash
# Descripción: Extrae el audio (MP3) de un video

ROJO='\033[0;31m'; VERDE='\033[0;32m'; NC='\033[0m'

if ! command -v ffmpeg &> /dev/null; then
    echo -e "${ROJO}FFmpeg (herramienta de video) no está instalado.${NC}"
    read -p "¿Instalar FFmpeg ahora? (s/n): " resp
    if [[ "$resp" == "s" ]]; then sudo apt update && sudo apt install -y ffmpeg; else exit 1; fi
fi

VIDEO=$1
if [ -z "$VIDEO" ]; then echo -e "${ROJO}Uso: adm media extraer-audio <video.mp4>${NC}"; exit 1; fi
SALIDA="${VIDEO%.*}.mp3"
ffmpeg -i "$VIDEO" -q:a 0 -map a "$SALIDA" && echo -e "${VERDE}✅ Audio extraído en: $SALIDA${NC}"
