#!/bin/bash
# Descripción: Hace un ping a un servidor para comprobar la conexión

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
URL=${1:-google.com}
echo "📡 Comprobando conexión con $URL..."
ping -c 4 "$URL"
