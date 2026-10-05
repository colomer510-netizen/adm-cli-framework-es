#!/bin/bash
# Descripción: Inicia un proyecto Node.js rápidamente

ROJO='\033[0;31m'; VERDE='\033[0;32m'; NC='\033[0m'

if ! command -v node &> /dev/null; then
    echo -e "${ROJO}Node.js no está instalado.${NC}"
    read -p "¿Instalar Node.js y npm? (s/n): " resp
    if [[ "$resp" == "s" ]]; then sudo apt update && sudo apt install -y nodejs npm; else exit 1; fi
fi

npm init -y && echo -e "${VERDE}✅ Proyecto Node.js inicializado (package.json creado).${NC}"
