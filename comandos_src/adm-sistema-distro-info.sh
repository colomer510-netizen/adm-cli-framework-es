#!/bin/bash
# Descripción: Muestra datos limpios sobre el sistema operativo
if [ -f /etc/os-release ]; then
    cat /etc/os-release | grep -E '^(NAME|VERSION|PRETTY_NAME)='
fi
echo -e "\033[0;34mArquitectura:\033[0m $(uname -m)"
