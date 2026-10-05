#!/bin/bash
# Descripción: Muestra la dirección IP local del equipo

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
echo "🌐 Obteniendo tu dirección IP..."
echo "IP Local (Red):"
ip -brief address show
echo ""
echo "IP Pública (Internet):"
curl -s ifconfig.me
echo ""
