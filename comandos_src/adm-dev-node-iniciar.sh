#!/bin/bash
# Descripción: Inicia un proyecto Node.js rápidamente

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

if ! command -v node &> /dev/null; then
    echo -e "${ROJO}Node.js no está instalado.${NC}"
    read -r -p "¿Instalar Node.js y npm? (s/n): " resp
    if [[ "$resp" == "s" ]]; then sudo apt update && sudo apt install -y nodejs npm; else exit 1; fi
fi

npm init -y && ok "Proyecto Node.js inicializado (package.json creado)."
