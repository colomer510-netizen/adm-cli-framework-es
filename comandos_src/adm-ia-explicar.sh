#!/bin/bash
# Descripción: Le pides a la IA que te explique un comando, error o concepto

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "ollama" "ollama"

if ! command -v ollama &> /dev/null; then
    error "Ollama no está instalado. Ejecuta primero: adm ia instalar"
    exit 1
fi

CONSULTA=$*
if [ -z "$CONSULTA" ]; then
    echo -e "${ROJO}Uso: adm ia explicar '<mensaje o error a explicar>'${NC}"
    exit 1
fi

PROMPT="Eres un ingeniero de sistemas Linux experto. Explica de forma breve, en español, y muy clara lo siguiente: $CONSULTA"

echo -e "${AZUL}Pensando...${NC}"
ollama run llama3.2 "$PROMPT"
