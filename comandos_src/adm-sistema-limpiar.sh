#!/bin/bash
# Descripción: Limpia la pantalla de la terminal

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
clear
