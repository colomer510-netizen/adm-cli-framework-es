#!/bin/bash
# Descripción: Actualiza la lista de paquetes y programas del sistema

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
echo "🔄 Iniciando actualización del sistema operativo..."
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y && sudo apt clean
echo "✅ Sistema actualizado y limpio."
