#!/bin/bash
# Descripción: Traduce lenguaje natural a formato crontab o viceversa

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "ollama" "ollama"
PROMPT=${*}
if [ -z "$PROMPT" ]; then echo "Uso: adm ia cron-traducir <descripcion>"; exit 1; fi
echo -e "\033[0;34mConsultando a Ollama...\033[0m"
ollama run llama3.2 "Traduce esta instrucción a formato cron o viceversa: $PROMPT. Solo dame el resultado exacto y una breve explicación de cada asterisco."
