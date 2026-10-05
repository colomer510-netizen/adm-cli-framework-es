#!/bin/bash
# Descripción: Lanza un contenedor Docker con herramientas de IA

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
/home/enoc-colomer/.scripts/admin_ia
