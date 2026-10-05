#!/bin/bash
# Descripción: Le pides a la IA que te explique un comando, error o concepto

ROJO='\033[0;31m'; AZUL='\033[0;34m'; NC='\033[0m'

if ! command -v ollama &> /dev/null; then
    echo -e "${ROJO}❌ Ollama no está instalado. Ejecuta primero: adm ia instalar${NC}"
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
