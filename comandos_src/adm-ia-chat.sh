#!/bin/bash
# Descripción: Inicia un chat libre con tu Inteligencia Artificial local

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "ollama" "ollama"

echo -e "${VERDE}Iniciando conexión neuronal con llama3.2... (Escribe /bye para salir)${NC}"
ollama run llama3.2
