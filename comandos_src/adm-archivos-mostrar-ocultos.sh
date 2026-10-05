#!/bin/bash
# Descripción: Muestra los archivos ocultos en el directorio actual
echo -e "\033[0;34mArchivos ocultos en el directorio actual:\033[0m"
ls -ld .?* 2>/dev/null || echo -e "\033[0;33mNo hay archivos ocultos aquí.\033[0m"
