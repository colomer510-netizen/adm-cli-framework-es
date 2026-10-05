#!/bin/bash
# Descripción: Muestra todos los archivos y carpetas del directorio

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
ls -la --color=auto
