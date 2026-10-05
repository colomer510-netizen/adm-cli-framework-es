#!/bin/bash
# Descripción: Busca archivos pesados en el directorio actual (Por defecto >500M)

RUTA=${1:-.}
MINIMO=${2:-500M}
echo -e "\033[1;33mBuscando archivos mayores a $MINIMO en $RUTA:\033[0m"
find "$RUTA" -type f -size +$MINIMO -exec ls -lh {} \; 2>/dev/null | awk '{ print $5 "\t" $9 }'
