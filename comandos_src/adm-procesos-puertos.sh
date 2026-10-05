#!/bin/bash
# Descripción: Muestra qué puertos de red está utilizando un proceso determinado

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
PID=$1
if [ -z "$PID" ]; then echo "Uso: adm procesos puertos <PID>"; exit 1; fi
lsof -i -P -n | grep "$PID"
