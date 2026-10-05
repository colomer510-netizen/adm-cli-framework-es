#!/bin/bash
# Descripción: Importa un modelo directamente desde un repositorio de HuggingFace

if [ "$#" -ne 2 ]; then
    echo -e "\033[0;33m⚠️ Uso: adm ollama importar-hf <nombre_para_el_modelo> <usuario_hf/repo_hf>\033[0m"
    echo "Ejemplo: adm ollama importar-hf mi_modelo bartowski/Qwen2.5-7B-Instruct-GGUF"
    exit 1
fi

NOMBRE_MODELO="$1"
REPO_HF="$2"

if ! command -v ollama &> /dev/null; then
    echo -e "\033[0;31m❌ Ollama no está instalado.\033[0m"
    exit 1
fi

echo -e "\033[1;36m🌐 Importando y descargando desde HuggingFace (hf.co/$REPO_HF)...\033[0m"

# Creamos un Modelfile temporal que apunte a HuggingFace
TEMP_MODELFILE=$(mktemp)
echo "FROM hf.co/$REPO_HF" > "$TEMP_MODELFILE"

# Ollama se encarga de ir a los servidores de HF y bajar el modelo
ollama create "$NOMBRE_MODELO" -f "$TEMP_MODELFILE"

# Limpiar
rm -f "$TEMP_MODELFILE"

echo -e "\n\033[1;32m✅ ¡Modelo '$NOMBRE_MODELO' importado desde HuggingFace con éxito!\033[0m"
