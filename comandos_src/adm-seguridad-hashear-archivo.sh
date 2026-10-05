#!/bin/bash
# Descripción: Calcula y muestra los hashes MD5 y SHA256 de un archivo

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
ARCHIVO=$1
if [ -z "$ARCHIVO" ]; then echo "Uso: adm seguridad hashear-archivo <archivo>"; exit 1; fi
echo -e "\033[0;34mMD5:\033[0m"
md5sum "$ARCHIVO"
echo -e "\033[0;34mSHA-256:\033[0m"
sha256sum "$ARCHIVO"
