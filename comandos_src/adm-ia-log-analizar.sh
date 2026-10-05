#!/bin/bash
# Descripción: Le pasas las últimas líneas de un log y la IA te dice la causa del error

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "ollama" "ollama"
LOG=$1
if [ -z "$LOG" ] || [ ! -f "$LOG" ]; then echo "Uso: adm ia log-analizar <archivo_log>"; exit 1; fi
echo -e "\033[0;34mAnalizando $LOG...\033[0m"
tail -n 100 "$LOG" | ollama run llama3.2 "Eres un sysadmin experto. Analiza este fragmento de log, encuentra los errores y explica de forma concisa en español la posible causa raíz y cómo solucionarlo:"
