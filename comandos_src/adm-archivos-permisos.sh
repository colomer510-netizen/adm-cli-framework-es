#!/bin/bash
# Descripción: Cambia los permisos (chmod) de un archivo
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Uso: adm archivos permisos <permisos_ej_755_o_+x> <archivo>"
    exit 1
fi
echo "🔐 Cambiando permisos de '$2' a '$1'..."
chmod "$1" "$2"
