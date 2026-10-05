#!/bin/bash
# Descripción: Muestra visualmente la jerarquía de procesos

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
if command -v pstree &> /dev/null; then
    pstree -p
else
    ps -ejH
fi
