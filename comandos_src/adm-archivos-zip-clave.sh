#!/bin/bash
# Descripción: Crea un archivo ZIP protegido con contraseña

ROJO='\033[0;31m'; VERDE='\033[0;32m'; NC='\033[0m'

if ! command -v zip &> /dev/null; then
    echo -e "${ROJO}La herramienta zip no está instalada.${NC}"
    read -p "¿Instalar zip ahora? (s/n): " resp
    if [[ "$resp" == "s" ]]; then sudo apt update && sudo apt install -y zip; else exit 1; fi
fi

ORIGEN=$1
DESTINO=${2:-"archivo_seguro.zip"}

if [ -z "$ORIGEN" ]; then echo -e "${ROJO}Uso: adm archivos zip-clave <carpeta/archivo> [nombre_salida.zip]${NC}"; exit 1; fi

zip -r -e "$DESTINO" "$ORIGEN"
echo -e "${VERDE}✅ Archivo cifrado creado: $DESTINO${NC}"
