#!/bin/bash
# Descripción: Cancela un apagado programado del sistema

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
sudo shutdown -c && echo -e "\033[0;32m✅ Apagado programado cancelado.\033[0m"
