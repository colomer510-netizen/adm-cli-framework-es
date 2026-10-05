#!/bin/bash
# Descripción: Escanea una carpeta en busca de virus con ClamAV

ROJO='\033[0;31m'; VERDE='\033[0;32m'; AMARILLO='\033[1;33m'; NC='\033[0m'

if ! command -v clamscan &> /dev/null; then
    echo -e "${ROJO}ClamAV (Antivirus libre) no está instalado.${NC}"
    read -p "¿Instalar ClamAV ahora? (s/n): " resp
    if [[ "$resp" == "s" ]]; then sudo apt update && sudo apt install -y clamav clamav-daemon && sudo freshclam; else exit 1; fi
fi

CARPETA=${1:-.}
echo -e "${AMARILLO}Escaneando la carpeta $CARPETA en busca de amenazas...${NC}"
clamscan -r "$CARPETA" | tail -n 10
