#!/bin/bash
# Descripción: Muestra qué modelos se están ejecutando actualmente y cuánta RAM/VRAM consumen

if ! command -v ollama &> /dev/null; then
    echo -e "\033[0;31m❌ Ollama no está instalado.\033[0m"
    exit 1
fi

echo -e "\033[1;36m🧠 Modelos ejecutándose en este momento (RAM/VRAM):\033[0m"
ollama ps
