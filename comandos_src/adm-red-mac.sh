#!/bin/bash
# Descripción: Muestra las direcciones MAC físicas de las interfaces de red

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
echo -e "\033[0;34mTus direcciones MAC físicas:\033[0m"
ip link | awk '/link\/ether/ {print $2}'
