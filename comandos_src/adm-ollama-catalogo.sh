#!/bin/bash
# Descripción: Muestra un catálogo sugerido de los mejores modelos que puedes descargar

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'

echo -e "\n${CYAN}╭────────────────────────────────────────────────────────╮${NC}"
echo -e "${CYAN}│${NC} 📚 ${MAGENTA}CATÁLOGO DE MODELOS RECOMENDADOS (OLLAMA)${NC}          ${CYAN}│${NC}"
echo -e "${CYAN}├────────────────────────────────────────────────────────┤${NC}"

# Función para imprimir filas
imprimir_fila() {
    printf "│ \033[1;32m%-15s\033[0m │ \033[1;33m%-7s\033[0m │ %-26s \033[1;36m│\033[0m\n" "$1" "$2" "$3"
}

printf "│ \033[1;34m%-15s\033[0m │ \033[1;34m%-7s\033[0m │ \033[1;34m%-26s\033[0m \033[1;36m│\033[0m\n" "MODELO" "PESO" "USO IDEAL"
echo -e "${CYAN}├─────────────────┼─────────┼────────────────────────────┤${NC}"

imprimir_fila "llama3.2" "2.0GB" "Rápido y excelente en español"
imprimir_fila "llama3.1" "4.7GB" "Potente, razonamiento avanzado"
imprimir_fila "mistral"  "4.1GB" "Buen equilibrio y programación"
imprimir_fila "phi3"     "2.4GB" "Muy rápido (creado por MS)"
imprimir_fila "qwen2.5"  "4.5GB" "Top mundial en varios idiomas"
imprimir_fila "gemma2"   "5.4GB" "Modelo inteligente de Google"
imprimir_fila "codellama" "3.8GB" "Asistente experto en código"
imprimir_fila "llava"    "4.7GB" "IA multimodal (lee imágenes)"

echo -e "${CYAN}╰────────────────────────────────────────────────────────╯${NC}\n"

echo -e "Para descargar cualquiera de estos, ejecuta:"
echo -e "👉 \033[1;33madm ollama descargar <modelo>\033[0m (Ej: adm ollama descargar qwen2.5)\n"
