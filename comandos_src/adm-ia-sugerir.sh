#!/bin/bash
# Descripción: Pide a la IA que te genere un comando de terminal específico

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "ollama" "ollama"

if ! command -v ollama &> /dev/null; then
    error "Ollama no está instalado. Ejecuta primero: adm ia instalar"
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
read -r -p "¿Deseas ejecutar este comando ahora? (s/n): " resp
if [[ "$resp" == "s" ]]; then
    eval "$COMANDO"
fi
