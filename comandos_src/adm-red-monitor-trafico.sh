#!/bin/bash
# Descripción: Muestra en tiempo real el tráfico de red de tu máquina

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "nethogs" "nethogs"
if command -v iftop &> /dev/null; then
    sudo iftop
elif command -v nload &> /dev/null; then
    nload
else
    echo "Instala nload o iftop: sudo apt install nload"
fi
