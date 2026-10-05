#!/bin/bash
# Descripción: Añade, hace commit y sube cambios a Git en un solo paso

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

requerir_cmd "git" "git"

MENSAJE=${1:-"Actualización automática"}
echo -e "${AMARILLO}Subiendo cambios a Git...${NC}"
git add .
git commit -m "$MENSAJE"
git push && ok "Cambios subidos a tu repositorio." || echo -e "${ROJO}Error al subir. ¿Estás dentro de un repositorio de Git?${NC}"
