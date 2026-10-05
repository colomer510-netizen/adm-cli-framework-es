#!/bin/bash
# Descripción: Lista los usuarios registrados en el sistema

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
echo "👥 Usuarios del sistema:"
cut -d: -f1 /etc/passwd
