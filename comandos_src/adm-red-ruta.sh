#!/bin/bash
# Descripción: Traza la ruta de red hacia un destino o dominio

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
DESTINO=${1:-google.com}
echo -e "\033[0;34mTrazando ruta de red hacia $DESTINO...\033[0m"
tracepath "$DESTINO"
