#!/bin/bash
# Descripción: Borra un archivo o directorio de forma permanente (pide confirmación)
source "$(dirname "$(readlink -f "$0")")/lib/comun.sh"
parsear_si "$@"; set -- "${ARGS[@]}"
if [ -z "$1" ]; then echo "Uso: adm archivos borrar [--si] <archivo_o_carpeta>"; exit 1; fi
[ -e "$1" ] || [ -L "$1" ] || { error "No existe: $1"; exit 1; }
case "$(realpath -m -- "$1")" in /|"$HOME"|/home|/etc|/usr|/bin|/boot|/var) error "Ruta protegida, no se borrará: $1"; exit 1;; esac
confirmar "¿Borrar permanentemente \"$1\"?" || { echo "Operación cancelada."; exit 1; }
rm -rf -- "$1" && ok "Elemento borrado."
