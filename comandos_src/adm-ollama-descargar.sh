#!/bin/bash
# Descripción: Descarga un nuevo modelo de IA (Ej: adm ollama descargar mistral)

if [ -z "$1" ]; then
    echo -e "\033[0;33m⚠️ Uso: adm ollama descargar <nombre_del_modelo>\033[0m"
    echo "Ejemplos: llama3.2, mistral, phi3, codellama"
    exit 1
fi

if ! command -v ollama &> /dev/null; then
    echo -e "\033[0;31m❌ Ollama no está instalado.\033[0m"
    exit 1
fi

echo -e "\033[1;36m⬇️ Descargando el modelo '$1'...\033[0m"
ollama pull "$1"
echo -e "\033[1;32m✅ ¡Descarga completada!\033[0m"
