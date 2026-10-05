#!/bin/bash
# Descripción: Lista los servicios que arrancan automáticamente

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'

echo -e "\n${CYAN}╭────────────────────────────────────────────────────────╮${NC}"
echo -e "${CYAN}│${NC} ⚙️  ${YELLOW}SERVICIOS DE INICIO (SYSTEMD)${NC}                      ${CYAN}│${NC}"
echo -e "${CYAN}├────────────────────────────────────────────────────────┤${NC}"

systemctl list-unit-files --state=enabled | head -n 20 | awk '
  NR==1 { printf "│ \033[1;34m%-40s %-12s\033[0m│\n", "ARCHIVO DE SERVICIO", "ESTADO" }
  NR>1 && NF>=2 {
    servicio = $1
    estado = $2
    if (estado == "enabled") estado = "\033[1;32m" estado "\033[0m"
    printf "│ %-40s %-21s│\n", substr(servicio, 1, 40), estado
  }
'
echo -e "${CYAN}╰────────────────────────────────────────────────────────╯${NC}\n"
