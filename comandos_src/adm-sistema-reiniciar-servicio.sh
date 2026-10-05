#!/bin/bash
# Descripción: Reinicia un servicio específico de systemd

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
if [ -z "$1" ]; then
    echo "Uso: adm sistema reiniciar-servicio <nombre_servicio>"
    exit 1
fi
echo "🔄 Reiniciando servicio '$1'..."
sudo systemctl restart "$1"
