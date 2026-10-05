#!/bin/bash
# Descripción: Instala un modelo personalizado desde un archivo .gguf

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

if [ "$#" -ne 2 ]; then
    echo -e "\033[0;33m⚠️ Uso: adm ollama importar-gguf <nombre_para_el_modelo> <ruta_al_archivo.gguf>\033[0m"
    echo "Ejemplo: adm ollama importar-gguf mi_ia /Descargas/llama-3-8b.gguf"
    exit 1
fi

NOMBRE_MODELO="$1"
ARCHIVO_GGUF="$2"

if [ ! -f "$ARCHIVO_GGUF" ]; then
    echo -e "\033[0;31m❌ Error: El archivo '$ARCHIVO_GGUF' no existe.\033[0m"
    exit 1
fi

if ! command -v ollama &> /dev/null; then
    echo -e "\033[0;31m❌ Ollama no está instalado.\033[0m"
    exit 1
fi

echo -e "\033[1;36m⚙️ Creando modelo '$NOMBRE_MODELO' a partir de archivo GGUF...\033[0m"

# Crear un Modelfile temporal
TEMP_MODELFILE=$(mktemp)
echo "FROM \"$ARCHIVO_GGUF\"" > "$TEMP_MODELFILE"

# Ejecutar la creación de ollama
ollama create "$NOMBRE_MODELO" -f "$TEMP_MODELFILE"

# Limpiar
rm -f "$TEMP_MODELFILE"

echo -e "\n\033[1;32m✅ ¡Modelo '$NOMBRE_MODELO' instalado con éxito!\033[0m"
echo -e "Puedes probarlo ejecutando: \033[1;33mollama run $NOMBRE_MODELO\033[0m"
