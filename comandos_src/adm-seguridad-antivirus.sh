#!/bin/bash
# Descripción: Escanea una carpeta en busca de virus con ClamAV

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "clamscan" "clamav"

CARPETA=${1:-.}
echo -e "${AMARILLO}Escaneando la carpeta $CARPETA en busca de amenazas...${NC}"
clamscan -r "$CARPETA" | tail -n 10
