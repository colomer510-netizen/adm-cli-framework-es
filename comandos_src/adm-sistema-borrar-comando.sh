#!/bin/bash
# Descripción: Elimina un comando existente de tu proyecto Gestor-Comandos-CLI de forma segura

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

CATEGORIA=$1
SUBCOMANDO=$2

if [ -z "$CATEGORIA" ] || [ -z "$SUBCOMANDO" ]; then
    echo -e "${ROJO}Uso: adm sistema borrar-comando <categoria> <subcomando>${NC}"
    echo -e "Ejemplo: adm sistema borrar-comando archivos buscar-pdf"
    exit 1
fi

DESTINO="$SCRIPT_DIR/adm-${CATEGORIA}-${SUBCOMANDO}.sh"

if [ ! -f "$DESTINO" ]; then
    error "Error: El comando 'adm $CATEGORIA $SUBCOMANDO' no existe en tu proyecto."
    exit 1
fi

aviso "ADVERTENCIA: Estás a punto de eliminar permanentemente el comando:"
echo -e "${AZUL}👉 adm $CATEGORIA $SUBCOMANDO${NC}"
echo -e "Archivo a borrar: $DESTINO"
echo ""

parsear_si "$@"; set -- "${ARGS[@]}"
confirmar "¿Eliminar permanentemente 'adm $CATEGORIA $SUBCOMANDO'?" || { echo "Operación cancelada."; exit 1; }
rm -f "$DESTINO"
ok "El comando 'adm $CATEGORIA $SUBCOMANDO' ha sido eliminado."
