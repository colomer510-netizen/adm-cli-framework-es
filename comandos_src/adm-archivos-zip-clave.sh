#!/bin/bash
# Descripción: Crea un archivo ZIP protegido con contraseña

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

requerir_cmd "zip" "zip"

ORIGEN=$1
DESTINO=${2:-"archivo_seguro.zip"}

if [ -z "$ORIGEN" ]; then echo -e "${ROJO}Uso: adm archivos zip-clave <carpeta/archivo> [nombre_salida.zip]${NC}"; exit 1; fi

zip -r -e "$DESTINO" "$ORIGEN"
ok "Archivo cifrado creado: $DESTINO"
