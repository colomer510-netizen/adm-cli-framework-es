#!/bin/bash
# Descripción: Muestra los 10 procesos que más memoria RAM consumen

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

echo -e "\033[1;33mTop 10 procesos consumiendo más RAM:\033[0m"
ps -eo pid,user,%mem,%cpu,comm --sort=-%mem | head -n 11
