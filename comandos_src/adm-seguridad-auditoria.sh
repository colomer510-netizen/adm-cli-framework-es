#!/bin/bash
# Descripción: Muestra los últimos inicios de sesión en el sistema

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
echo -e "\033[0;34mÚltimos inicios de sesión:\033[0m"
last -a | head -n 15
