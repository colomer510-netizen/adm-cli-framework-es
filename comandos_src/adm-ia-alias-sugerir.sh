#!/bin/bash
# Descripción: La IA lee tu historial de comandos recientes y te sugiere configuraciones de alias

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
requerir_cmd "ollama" "ollama"
echo -e "\033[0;34mAnalizando tu historial reciente...\033[0m"
tail -n 200 ~/.bash_history | ollama run llama3.2 "Eres un experto en Linux. Analiza este historial de bash y sugiere 5 alias útiles que me ahorrarían tiempo, basándote en los comandos que más uso o los más largos. Dame el código listo para poner en .bashrc y explica brevemente qué hace cada uno."
