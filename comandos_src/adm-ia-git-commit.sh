#!/bin/bash
# Descripción: La IA lee automáticamente tu git diff y redacta un mensaje de commit
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then echo "No estás en un repositorio Git."; exit 1; fi
DIFF=$(git diff --staged)
if [ -z "$DIFF" ]; then DIFF=$(git diff); fi
if [ -z "$DIFF" ]; then echo "No hay cambios en Git."; exit 1; fi
echo -e "\033[0;34mGenerando commit...\033[0m"
echo "$DIFF" | ollama run llama3.2 "Eres un desarrollador experto. Basado en el siguiente git diff, escribe un mensaje de commit conciso y descriptivo en formato 'Conventional Commits'. Solo dame el mensaje, nada más. Diff: "
