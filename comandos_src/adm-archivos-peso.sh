#!/bin/bash
# Descripción: Calcula el tamaño de una carpeta o archivo

TARGET=${1:-.}
echo -e "\033[0;34mCalculando el tamaño de:\033[0m $TARGET"
du -sh "$TARGET" 2>/dev/null || echo -e "\033[0;31mPermiso denegado en algunos subdirectorios.\033[0m"
