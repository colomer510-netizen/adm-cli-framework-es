#!/bin/bash
# Descripción: Escanea y lista las IP de los dispositivos conectados a tu red local

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "nmap" "nmap"
IP=$(ip route | grep default | awk '{print $3}')
if [ -z "$IP" ]; then echo "No se pudo detectar la red local."; exit 1; fi
RED=$(echo $IP | cut -d. -f1-3).0/24
echo -e "\033[0;34mEscaneando red $RED con nmap (puede requerir sudo)...\033[0m"
if command -v nmap &> /dev/null; then
    nmap -sn "$RED"
else
    echo "nmap no está instalado. Ejecuta: sudo apt install nmap"
fi
