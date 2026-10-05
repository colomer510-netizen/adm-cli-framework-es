#!/bin/bash
# Descripción: Muestra el estado del servicio en segundo plano de Ollama (systemctl)

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

echo -e "\033[1;36m⚙️ Estado del motor de IA (Servicio Ollama):\033[0m"
systemctl status ollama --no-pager | head -n 10
