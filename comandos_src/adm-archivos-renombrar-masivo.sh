#!/bin/bash
# Descripción: Agrega un prefijo a todos los archivos del directorio actual (pide confirmación)
source "$(dirname "$(readlink -f "$0")")/lib/comun.sh"
parsear_si "$@"; set -- "${ARGS[@]}"
PREFIJO=$1
if [ -z "$PREFIJO" ]; then echo "Uso: adm archivos renombrar-masivo [--si] <prefijo>"; exit 1; fi
confirmar "Se renombrarán los archivos de $(pwd) con el prefijo \"$PREFIJO\". ¿Continuar?" || { echo "Operación cancelada."; exit 1; }
for file in *; do
    if [ -f "$file" ]; then
        mv -n -- "$file" "${PREFIJO}${file}" && echo "Renombrado: $file -> ${PREFIJO}${file}"
    fi
done
