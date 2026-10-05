#!/bin/bash
# Descripción: Instala Ollama y descarga el modelo de IA base (llama3.2)

ROJO='\033[0;31m'; VERDE='\033[0;32m'; AZUL='\033[0;34m'; AMARILLO='\033[1;33m'; NC='\033[0m'

echo -e "${AZUL}=============================================${NC}"
echo -e "${AZUL}   🧠 INSTALADOR DE CEREBRO IA (Ollama)      ${NC}"
echo -e "${AZUL}=============================================${NC}"

if ! command -v ollama &> /dev/null; then
    echo -e "${AMARILLO}Ollama no está instalado. Iniciando instalación segura...${NC}"
    curl -fsSL https://ollama.com/install.sh | sh
else
    echo -e "${VERDE}✅ El motor Ollama ya está instalado en tu sistema.${NC}"
fi

echo -e "\n${AMARILLO}Verificando el modelo de lenguaje 'llama3.2'...${NC}"
if ollama list | grep -q "llama3.2"; then
    echo -e "${VERDE}✅ El modelo 'llama3.2' ya está listo para usarse.${NC}"
else
    echo -e "${AMARILLO}Descargando el modelo 'llama3.2' (esto puede tardar unos minutos dependiendo de tu internet)...${NC}"
    ollama pull llama3.2
    echo -e "${VERDE}✅ Modelo instalado correctamente.${NC}"
fi
echo -e "${AZUL}=============================================${NC}"
echo -e "Ya puedes usar: adm ia chat, adm ia explicar, adm ia sugerir"
