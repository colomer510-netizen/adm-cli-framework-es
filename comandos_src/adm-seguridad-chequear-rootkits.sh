#!/bin/bash
# Descripción: Ejecuta un escaneo básico en busca de rootkits/malware

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "rkhunter" "rkhunter"
if command -v rkhunter &> /dev/null; then
    sudo rkhunter --check --sk
elif command -v chkrootkit &> /dev/null; then
    sudo chkrootkit
else
    echo "Instala rkhunter o chkrootkit para usar este comando: sudo apt install rkhunter"
fi
