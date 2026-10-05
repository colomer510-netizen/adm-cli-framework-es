#!/bin/bash
# Descripción: Elimina un comando existente de tu proyecto Gestor-Comandos-CLI de forma segura

ROJO='\033[0;31m'; VERDE='\033[0;32m'; AZUL='\033[0;34m'; AMARILLO='\033[1;33m'; NC='\033[0m'
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

CATEGORIA=$1
SUBCOMANDO=$2

if [ -z "$CATEGORIA" ] || [ -z "$SUBCOMANDO" ]; then
    echo -e "${ROJO}Uso: adm sistema borrar-comando <categoria> <subcomando>${NC}"
    echo -e "Ejemplo: adm sistema borrar-comando archivos buscar-pdf"
    exit 1
fi

DESTINO="$SCRIPT_DIR/adm-${CATEGORIA}-${SUBCOMANDO}.sh"

if [ ! -f "$DESTINO" ]; then
    echo -e "${ROJO}❌ Error: El comando 'adm $CATEGORIA $SUBCOMANDO' no existe en tu proyecto.${NC}"
    exit 1
fi

echo -e "${AMARILLO}⚠️ ADVERTENCIA: Estás a punto de eliminar permanentemente el comando:${NC}"
echo -e "${AZUL}👉 adm $CATEGORIA $SUBCOMANDO${NC}"
echo -e "Archivo a borrar: $DESTINO"
echo ""

read -p "¿Estás completamente seguro? (s/n): " resp
if [[ "$resp" == "s" ]]; then
    rm -f "$DESTINO"
    echo -e "${VERDE}✅ El comando ha sido desintegrado de tu sistema con éxito.${NC}"
else
    echo -e "Operación cancelada. El comando está a salvo."
fi
