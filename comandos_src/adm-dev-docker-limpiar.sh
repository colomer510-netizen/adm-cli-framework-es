#!/bin/bash
# Descripción: Elimina contenedores detenidos, redes sin uso e imágenes huérfanas

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "docker" "docker.io"
echo -e "\033[0;33mLimpiando Docker (requiere permisos)\033[0m"
docker system prune -f
