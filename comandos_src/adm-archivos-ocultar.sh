#!/bin/bash
# Descripción: Oculta un archivo o carpeta agregando un punto al inicio de su nombre
TARGET=${1}
if [ -z "$TARGET" ]; then echo -e "\033[0;31mError: Faltan argumentos. Uso: adm archivos ocultar <archivo/carpeta>\033[0m"; exit 1; fi
mv "$TARGET" ".$TARGET" 2>/dev/null && echo -e "\033[0;32m✅ Ocultado como .$TARGET\033[0m" || echo -e "\033[0;31mError al ocultar.\033[0m"
