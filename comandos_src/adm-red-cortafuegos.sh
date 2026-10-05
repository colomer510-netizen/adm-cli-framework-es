#!/bin/bash
# Descripción: Gestiona el estado del Firewall (UFW)

ROJO='\033[0;31m'; VERDE='\033[0;32m'; NC='\033[0m'

if ! command -v ufw &> /dev/null; then
    echo -e "${ROJO}UFW no está instalado.${NC}"
    read -p "¿Instalar UFW? (s/n): " resp
    if [[ "$resp" == "s" ]]; then sudo apt update && sudo apt install -y ufw; else exit 1; fi
fi

if [ "$1" == "activar" ]; then
    sudo ufw enable && echo -e "${VERDE}✅ Cortafuegos Activado.${NC}"
elif [ "$1" == "desactivar" ]; then
    sudo ufw disable && echo -e "${ROJO}⚠️ Cortafuegos Desactivado.${NC}"
else
    sudo ufw status verbose
    echo -e "\nOpciones: adm red cortafuegos [activar|desactivar]"
fi
