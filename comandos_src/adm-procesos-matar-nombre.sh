#!/bin/bash
# Descripción: Mata todos los procesos que coincidan con un nombre (pide confirmación)
source "$(dirname "$(readlink -f "$0")")/lib/comun.sh"
parsear_si "$@"; set -- "${ARGS[@]}"
NOMBRE=$1
if [ -z "$NOMBRE" ]; then echo "Uso: adm procesos matar-nombre [--si] <nombre>"; exit 1; fi
echo "Procesos que coinciden con \"$NOMBRE\":"; pgrep -af -- "$NOMBRE" | grep -v "matar-nombre" || { error "Ninguno encontrado."; exit 1; }
confirmar "¿Finalizar todos ellos?" || { echo "Operación cancelada."; exit 1; }
pkill -f -- "$NOMBRE" && ok "Procesos con nombre \"$NOMBRE\" finalizados."
