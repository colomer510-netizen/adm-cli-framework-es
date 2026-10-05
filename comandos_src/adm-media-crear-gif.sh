#!/bin/bash
# Descripción: Convierte un fragmento de video en un archivo GIF animado

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "ffmpeg" "ffmpeg"
ENTRADA=$1
SALIDA=$2
if [ -z "$SALIDA" ]; then echo "Uso: adm media crear-gif <entrada.mp4> <salida.gif>"; exit 1; fi
ffmpeg -i "$ENTRADA" -vf "fps=10,scale=320:-1:flags=lanczos" -c:v gif "$SALIDA"
