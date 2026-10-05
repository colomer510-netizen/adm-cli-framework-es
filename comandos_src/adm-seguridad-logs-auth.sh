#!/bin/bash
# Descripción: Lee los logs del sistema para mostrar intentos fallidos de inicio de sesión

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
echo -e "\033[0;33mÚltimos fallos de autenticación (requiere sudo):\033[0m"
if [ -f /var/log/auth.log ]; then
    sudo grep -i "failed" /var/log/auth.log | tail -n 20
elif [ -f /var/log/secure ]; then
    sudo grep -i "failed" /var/log/secure | tail -n 20
else
    echo "No se encontró archivo de log de autenticación estándar."
fi
