#!/bin/bash
# Descripción: Pide a la IA que te genere un comando de terminal específico

ROJO='\033[0;31m'; VERDE='\033[0;32m'; AMARILLO='\033[1;33m'; NC='\033[0m'

if ! command -v ollama &> /dev/null; then
    echo -e "${ROJO}❌ Ollama no está instalado. Ejecuta primero: adm ia instalar${NC}"
    exit 1
fi

CONSULTA=$*
if [ -z "$CONSULTA" ]; then
    echo -e "${ROJO}Uso: adm ia sugerir '<qué quieres hacer>'${NC}"
    echo -e "Ejemplo: adm ia sugerir 'buscar archivos mayores a 1GB'"
    exit 1
fi

PROMPT="Actúa como un generador de comandos Linux de Ubuntu. El usuario quiere: $CONSULTA. 
Responde ÚNICAMENTE con el comando de terminal exacto, sin explicaciones ni formato markdown, solo el texto puro del comando."

echo -e "${AMARILLO}Generando comando...${NC}\n"
COMANDO=$(ollama run llama3.2 "$PROMPT" | grep -v '```' | sed 's/^`//' | sed 's/`$//' | sed '/^[[:space:]]*$/d')

echo -e "${VERDE}Comando sugerido:${NC}"
echo -e "$COMANDO"
echo ""
read -p "¿Deseas ejecutar este comando ahora? (s/n): " resp
if [[ "$resp" == "s" ]]; then
    eval "$COMANDO"
fi
