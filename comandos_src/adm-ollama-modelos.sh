#!/bin/bash
# Descripción: Muestra todos los modelos de IA descargados en tu equipo

if ! command -v ollama &> /dev/null; then
    echo -e "\033[0;31m❌ Ollama no está instalado. Ejecuta: adm ia instalar\033[0m"
    exit 1
fi

echo -e "\033[1;36m📦 Modelos de Inteligencia Artificial instalados:\033[0m"
ollama list
