#!/bin/bash
# Descripción: Muestra los puertos de red abiertos y a la escucha

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'

echo -e "\n${CYAN}╭────────────────────────────────────────────────────────╮${NC}"
echo -e "${CYAN}│${NC} 🚪 ${YELLOW}PUERTOS ABIERTOS Y A LA ESCUCHA${NC}                    ${CYAN}│${NC}"
echo -e "${CYAN}├────────────────────────────────────────────────────────┤${NC}"

ss -tuln | awk '
  NR==1 { printf "│ \033[1;34m%-8s %-6s %-6s %-20s %-10s\033[0m│\n", "PROTO", "RECV-Q", "SEND-Q", "DIRECCIÓN LOCAL", "PUERTO" }
  NR>1 {
    # Extraer el puerto de la IP (ejemplo 127.0.0.1:80 -> 80)
    split($5, a, ":")
    puerto = a[length(a)]
    
    # Colorear protocolos
    proto = $1
    if (proto ~ /tcp/) proto = "\033[1;32m" proto "\033[0m"
    if (proto ~ /udp/) proto = "\033[1;33m" proto "\033[0m"

    printf "│ %-17s %-6s %-6s %-20s \033[1;36m%-10s\033[0m│\n", proto, $2, $3, substr($5, 1, 20), puerto
  }
'
echo -e "${CYAN}╰────────────────────────────────────────────────────────╯${NC}\n"
