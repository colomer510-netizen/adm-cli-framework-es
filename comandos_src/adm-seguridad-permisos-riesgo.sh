#!/bin/bash
# Descripción: Busca archivos en tu sistema que tengan permisos 777 (riesgo de seguridad)

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
DIR=${1:-.}
echo -e "\033[0;31mBuscando archivos con permisos 777 en $DIR...\033[0m"
find "$DIR" -type f -perm 0777
