#!/bin/bash
# Descripción: Inicia un chat libre con tu Inteligencia Artificial local

ROJO='\033[0;31m'; VERDE='\033[0;32m'; AMARILLO='\033[1;33m'; NC='\033[0m'

if ! command -v ollama &> /dev/null; then
    echo -e "${ROJO}❌ Ollama no está instalado. Ejecuta primero: adm ia instalar${NC}"
    exit 1
fi

echo -e "${VERDE}Iniciando conexión neuronal con llama3.2... (Escribe /bye para salir)${NC}"
ollama run llama3.2
