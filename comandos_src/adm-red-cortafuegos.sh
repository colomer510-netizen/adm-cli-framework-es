#!/bin/bash
# Descripción: Gestiona el estado del Firewall (UFW)

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

requerir_cmd "ufw" "ufw"

if [ "$1" == "activar" ]; then
    sudo ufw enable && ok "Cortafuegos Activado."
elif [ "$1" == "desactivar" ]; then
    sudo ufw disable && echo -e "${ROJO}⚠️ Cortafuegos Desactivado.${NC}"
else
    sudo ufw status verbose
    echo -e "\nOpciones: adm red cortafuegos [activar|desactivar]"
fi
