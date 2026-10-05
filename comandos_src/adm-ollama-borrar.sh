#!/bin/bash
# Descripción: Elimina un modelo de IA para liberar espacio en el disco

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

if [ -z "$1" ]; then
    echo -e "\033[0;33m⚠️ Uso: adm ollama borrar <nombre_del_modelo>\033[0m"
    echo -e "Puedes ver tus modelos con: \033[1;36madm ollama modelos\033[0m"
    exit 1
fi

if ! command -v ollama &> /dev/null; then
    echo -e "\033[0;31m❌ Ollama no está instalado.\033[0m"
    exit 1
fi

echo -e "\033[1;31m🗑️ Borrando el modelo '$1'...\033[0m"
ollama rm "$1"
echo -e "\033[1;32m✅ Modelo eliminado. Espacio liberado.\033[0m"
