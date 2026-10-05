#!/bin/bash
# Descripción: Concatena el contenido de varios archivos de texto y los junta en uno solo
SALIDA=$1
shift
if [ -z "$SALIDA" ] || [ -z "$1" ]; then echo "Uso: adm archivos unir <archivo_salida> <archivo1> <archivo2> ..."; exit 1; fi
cat "$@" > "$SALIDA"
echo -e "\033[0;32mArchivos unidos en: $SALIDA\033[0m"
