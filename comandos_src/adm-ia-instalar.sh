#!/bin/bash
# Descripción: Instala Ollama y descarga el modelo de IA base (llama3.2)

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

echo -e "${AZUL}=============================================${NC}"
echo -e "${AZUL}   🧠 INSTALADOR DE CEREBRO IA (Ollama)      ${NC}"
echo -e "${AZUL}=============================================${NC}"

if ! command -v ollama &> /dev/null; then
    echo -e "${AMARILLO}Ollama no está instalado. Iniciando instalación segura...${NC}"
    curl -fsSL https://ollama.com/install.sh | sh
else
    ok "El motor Ollama ya está instalado en tu sistema."
fi

echo -e "\n${AMARILLO}Verificando el modelo de lenguaje 'llama3.2'...${NC}"
if ollama list | grep -q "llama3.2"; then
    ok "El modelo 'llama3.2' ya está listo para usarse."
else
    echo -e "${AMARILLO}Descargando el modelo 'llama3.2' (esto puede tardar unos minutos dependiendo de tu internet)...${NC}"
    ollama pull llama3.2
    ok "Modelo instalado correctamente."
fi
echo -e "${AZUL}=============================================${NC}"
echo -e "Ya puedes usar: adm ia chat, adm ia explicar, adm ia sugerir"
