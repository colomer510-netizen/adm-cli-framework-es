#!/bin/bash
# Descripción: Muestra información general sobre el sistema operativo

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
echo "💻 Información del Sistema:"
if command -v neofetch &> /dev/null; then
    neofetch
elif command -v fastfetch &> /dev/null; then
    fastfetch
else
    uname -a
    echo ""
    cat /etc/os-release | grep PRETTY_NAME
fi
