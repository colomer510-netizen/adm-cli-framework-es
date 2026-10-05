#!/bin/bash
# Descripción: Muestra la temperatura de la placa o CPU

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

echo -e "\033[0;31mTemperatura del Sistema:\033[0m"
cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | awk '{print $1/1000 " °C"}' | head -n 1 || echo "Sensores no detectados."
