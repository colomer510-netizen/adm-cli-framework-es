#!/bin/bash
# Descripción: Muestra cuánto tiempo lleva encendida la máquina y la carga promedio

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"


echo -e "\n${CYAN}╭────────────────────────────────────────────────────────╮${NC}"
echo -e "${CYAN}│${NC} 🕒 ${YELLOW}TIEMPO DE ACTIVIDAD Y CARGA DEL SISTEMA${NC}            ${CYAN}│${NC}"
echo -e "${CYAN}├────────────────────────────────────────────────────────┤${NC}"

# Extraer el tiempo encendido amigable
TIEMPO=$(uptime -p | sed 's/up //')
# Extraer usuarios y carga
INFO=$(uptime | sed 's/.*up.*, //')

echo -e "│ \033[1;32mTiempo encendido:\033[0m $TIEMPO" | awk '{printf "%-65s \033[1;36m│\033[0m\n", $0}'
echo -e "│ \033[1;32mDetalles:\033[0m $INFO" | awk '{printf "%-65s \033[1;36m│\033[0m\n", $0}'

echo -e "${CYAN}╰────────────────────────────────────────────────────────╯${NC}\n"
