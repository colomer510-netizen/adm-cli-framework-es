#!/bin/bash
# Descripción: Congela la ejecución de un proceso mediante su PID

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
PID=${1}
if [ -z "$PID" ]; then echo -e "\033[0;31mUso: adm procesos congelar <PID>\033[0m"; exit 1; fi
kill -STOP $PID && echo -e "\033[0;32m✅ Proceso $PID congelado.\033[0m"
