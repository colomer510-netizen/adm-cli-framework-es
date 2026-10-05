#!/bin/bash
# Descripción: Muestra los registros (logs) del sistema

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
echo "📜 Mostrando los últimos errores del sistema..."
journalctl -p 3 -xb
