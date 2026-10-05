#!/bin/bash
# Descripción: Muestra los dispositivos de almacenamiento USB conectados

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
echo -e "\033[0;34mDispositivos de almacenamiento USB conectados:\033[0m"
lsblk -o NAME,SIZE,MODEL,MOUNTPOINT,TRAN | grep -i "usb" || echo -e "\033[0;33mNo hay USBs conectados.\033[0m"
