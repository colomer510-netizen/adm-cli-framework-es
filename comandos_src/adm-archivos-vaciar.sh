#!/bin/bash
# Descripción: Vacía el contenido de un archivo de texto dejándolo en blanco
source "$(dirname "$(readlink -f "$0")")/lib/comun.sh"
parsear_si "$@"; set -- "${ARGS[@]}"
ARCHIVO=$1
if [ -z "$ARCHIVO" ]; then echo "Uso: adm archivos vaciar [--si] <archivo>"; exit 1; fi
[ -f "$ARCHIVO" ] || { error "No existe el archivo: $ARCHIVO"; exit 1; }
confirmar "Se perderá todo el contenido de $ARCHIVO. ¿Continuar?" || { echo "Operación cancelada."; exit 1; }
: > "$ARCHIVO"
ok "El archivo $ARCHIVO ha sido vaciado."
