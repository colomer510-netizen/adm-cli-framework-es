#!/bin/bash
# Descripción: Muestra los metadatos de un archivo multimedia
ARCHIVO=$1
if [ -z "$ARCHIVO" ]; then echo "Uso: adm media info <archivo>"; exit 1; fi
if command -v ffprobe &> /dev/null; then
    ffprobe -hide_banner "$ARCHIVO"
elif command -v mediainfo &> /dev/null; then
    mediainfo "$ARCHIVO"
else
    echo "Se requiere instalar ffmpeg o mediainfo."
fi
