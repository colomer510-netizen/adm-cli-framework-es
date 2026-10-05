#!/bin/bash
# Descripción: Muestra cuánto tiempo lleva ejecutándose un proceso

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
PID=$1
if [ -z "$PID" ]; then echo "Uso: adm procesos tiempo-uso <PID>"; exit 1; fi
ps -p "$PID" -o pid,etime,cmd
