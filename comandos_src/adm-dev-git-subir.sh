#!/bin/bash
# Descripción: Añade, hace commit y sube cambios a Git en un solo paso

ROJO='\033[0;31m'; VERDE='\033[0;32m'; AMARILLO='\033[1;33m'; NC='\033[0m'

if ! command -v git &> /dev/null; then
    echo -e "${ROJO}Git no está instalado.${NC}"
    read -p "¿Deseas instalar Git ahora? (s/n): " resp
    if [[ "$resp" == "s" ]]; then sudo apt update && sudo apt install -y git; else exit 1; fi
fi

MENSAJE=${1:-"Actualización automática"}
echo -e "${AMARILLO}Subiendo cambios a Git...${NC}"
git add .
git commit -m "$MENSAJE"
git push && echo -e "${VERDE}✅ Cambios subidos a tu repositorio.${NC}" || echo -e "${ROJO}Error al subir. ¿Estás dentro de un repositorio de Git?${NC}"
