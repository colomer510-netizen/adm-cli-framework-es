#!/bin/bash
# Descripción: Genera una contraseña criptográficamente segura

LONGITUD=${1:-16}
echo -e "\033[0;32mGenerando contraseña segura de $LONGITUD caracteres:\033[0m"
tr -dc 'A-Za-z0-9!@#$%^&*_+=' < /dev/urandom | head -c "$LONGITUD"
echo ""
