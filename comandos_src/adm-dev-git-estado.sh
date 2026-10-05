#!/bin/bash
# Descripción: Resumen rápido y colorido que muestra la rama actual y los archivos modificados
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then echo "No estás en un repositorio Git."; exit 1; fi
echo -e "\033[0;34mRama actual:\033[0m"
git branch --show-current
echo -e "\033[0;34mEstado:\033[0m"
git status -s
