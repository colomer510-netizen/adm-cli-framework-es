#!/bin/bash
# Descripción: Cuenta y muestra cuántos archivos y carpetas hay dentro de un directorio

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

DIR=${1:-.}

CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'

ARCHIVOS=$(find "$DIR" -type f 2>/dev/null | wc -l)
CARPETAS=$(find "$DIR" -type d 2>/dev/null | wc -l)

echo -e "\n${CYAN}╭────────────────────────────────────────────────────────╮${NC}"
echo -e "${CYAN}│${NC} 📊 ${MAGENTA}ESTADÍSTICAS DEL DIRECTORIO${NC}                        ${CYAN}│${NC}"
echo -e "${CYAN}├────────────────────────────────────────────────────────┤${NC}"

# Formateo dinámico para ajustar a la caja
echo -e "│ \033[1;33mRuta Analizada:\033[0m $DIR" | awk '{printf "%-65s \033[1;36m│\033[0m\n", $0}'
echo -e "│ \033[1;32mTotal Archivos:\033[0m $ARCHIVOS" | awk '{printf "%-65s \033[1;36m│\033[0m\n", $0}'
echo -e "│ \033[1;32mTotal Carpetas:\033[0m $CARPETAS" | awk '{printf "%-65s \033[1;36m│\033[0m\n", $0}'

echo -e "${CYAN}╰────────────────────────────────────────────────────────╯${NC}\n"
