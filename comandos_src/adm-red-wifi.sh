#!/bin/bash
# Descripción: Muestra información de la conexión WiFi

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
echo "📶 Buscando redes WiFi disponibles..."
nmcli dev wifi list
