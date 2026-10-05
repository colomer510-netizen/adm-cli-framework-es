#!/bin/bash
# Descripción: Muestra la ruta absoluta del directorio actual (pwd)

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
pwd
