#!/bin/bash
# Descripción: Muestra el historial de los últimos comandos usados

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
LINEAS=${1:-20}
echo -e "\033[1;33mMostrando los últimos $LINEAS comandos usados:\033[0m"
cat ~/.bash_history | tail -n "$LINEAS"
