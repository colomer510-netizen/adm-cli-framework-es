#!/bin/bash
# Descripción: Muestra los usuarios actualmente conectados al sistema

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
echo -e "\033[0;34mUsuarios actualmente conectados al sistema:\033[0m"
w
