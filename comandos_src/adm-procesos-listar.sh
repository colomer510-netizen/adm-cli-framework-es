#!/bin/bash
# Descripción: Muestra una lista de todos los procesos activos

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
echo "📊 Mostrando procesos..."
if command -v htop &> /dev/null; then
    htop
else
    top
fi
