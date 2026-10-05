#!/bin/bash
# Descripción: Fuerza el cierre (kill -9) de un proceso por PID o nombre exacto (pide confirmación)
source "$(dirname "$(readlink -f "$0")")/lib/comun.sh"
parsear_si "$@"; set -- "${ARGS[@]}"
if [ -z "$1" ]; then echo "Uso: adm procesos matar [--si] <nombre_o_PID>"; exit 1; fi
confirmar "¿Forzar el cierre de \"$1\"?" || { echo "Operación cancelada."; exit 1; }
if es_entero "$1"; then kill -9 "$1"; else killall -9 -- "$1"; fi && ok "Proceso \"$1\" finalizado."
