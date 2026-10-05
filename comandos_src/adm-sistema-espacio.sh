#!/bin/bash
# Descripción: Muestra el espacio libre y ocupado en los discos (df)

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'

echo -e "\n${YELLOW}💾 ESTADO DE LOS DISCOS DE ALMACENAMIENTO:${NC}\n"

df -h -x tmpfs -x devtmpfs -x squashfs | awk '
  NR==1 { printf "  \033[1;34m%-15s %-10s %-10s %-10s %-10s %-15s\033[0m\n", "SISTEMA", "TAMAÑO", "USADO", "LIBRE", "USO %", "MONTAJE" }
  NR>1 {
    # Color según el porcentaje de uso
    uso = $5+0
    color = "\033[1;32m" # Verde por defecto
    if (uso > 75) color = "\033[1;33m" # Amarillo si > 75%
    if (uso > 90) color = "\033[1;31m" # Rojo si > 90%
    
    printf "  %-15s %-10s %-10s %-10s %s%-10s\033[0m %-15s\n", substr($1,1,15), $2, $3, $4, color, $5, $6
  }
'
echo ""
