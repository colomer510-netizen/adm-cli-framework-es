#!/bin/bash
# Descripción: Compara dos archivos y muestra sus diferencias

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
if [ -z "$1" ] || [ -z "$2" ]; then echo -e "\033[0;31mUso: adm archivos comparar <archivo1> <archivo2>\033[0m"; exit 1; fi
diff -u "$1" "$2" || echo -e "\033[0;33m👆 Esas son las diferencias. Si no salió nada, son idénticos.\033[0m"
