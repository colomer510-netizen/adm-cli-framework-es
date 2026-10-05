#!/bin/bash
# Descripción: Obtiene la IP Pública de internet del servidor

echo -e "\033[0;34mConsultando tu IP Pública de Internet...\033[0m"
IP=$(curl -s --max-time 5 ifconfig.me)
if [ -n "$IP" ]; then
    echo -e "\033[0;32mTu IP Pública actual es:\033[0m $IP"
else
    echo -e "\033[0;31mError al obtener la IP. Revisa tu conexión a internet.\033[0m"
fi
