#!/bin/bash
# Descripción: Ejecuta un test rápido de velocidad de descarga y subida

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "speedtest-cli" "speedtest-cli"
if command -v speedtest-cli &> /dev/null; then
    speedtest-cli
else
    echo "Necesitas instalar speedtest-cli. Ejecuta: sudo apt install speedtest-cli"
fi
