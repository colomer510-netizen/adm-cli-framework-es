#!/bin/bash
# Descripción: Crea un modelo a partir de un archivo Modelfile personalizado (con prompts y parámetros)

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

if [ "$#" -ne 2 ]; then
    echo -e "\033[0;33m⚠️ Uso: adm ollama importar-modelfile <nombre_del_modelo> <ruta_al_Modelfile>\033[0m"
    echo "Ejemplo: adm ollama importar-modelfile asistente_codigo ./Modelfile"
    exit 1
fi

NOMBRE_MODELO="$1"
ARCHIVO_MODELFILE="$2"

if [ ! -f "$ARCHIVO_MODELFILE" ]; then
    echo -e "\033[0;31m❌ Error: El archivo '$ARCHIVO_MODELFILE' no existe.\033[0m"
    exit 1
fi

if ! command -v ollama &> /dev/null; then
    echo -e "\033[0;31m❌ Ollama no está instalado.\033[0m"
    exit 1
fi

echo -e "\033[1;36m⚙️ Compilando modelo '$NOMBRE_MODELO' usando tu Modelfile...\033[0m"

ollama create "$NOMBRE_MODELO" -f "$ARCHIVO_MODELFILE"

echo -e "\n\033[1;32m✅ ¡Modelo '$NOMBRE_MODELO' compilado con éxito!\033[0m"
