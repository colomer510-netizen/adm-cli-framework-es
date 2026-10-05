#!/bin/bash
# Descripción: Lista los servicios activos en el sistema

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

CYAN='\033[1;36m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'

echo -e "\n${CYAN}╭────────────────────────────────────────────────────────╮${NC}"
echo -e "${CYAN}│${NC} 🚀 ${YELLOW}TOP 15 SERVICIOS ACTIVOS${NC}                           ${CYAN}│${NC}"
echo -e "${CYAN}├────────────────────────────────────────────────────────┤${NC}"

systemctl list-units --type=service --state=running | head -n 16 | awk '
  NR==1 { printf "│ \033[1;34m%-35s %-16s\033[0m │\n", "SERVICIO", "ESTADO" }
  NR>1 && NF>=4 {
    servicio = $1
    estado = $4
    if (estado == "running") estado = "\033[1;32m" estado "\033[0m"
    printf "│ %-35s %-25s │\n", substr(servicio, 1, 35), estado
  }
'
echo -e "${CYAN}╰────────────────────────────────────────────────────────╯${NC}\n"
