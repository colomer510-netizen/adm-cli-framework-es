#!/bin/bash
# Descripción: Muestra información general sobre el sistema operativo
echo "💻 Información del Sistema:"
if command -v neofetch &> /dev/null; then
    neofetch
elif command -v fastfetch &> /dev/null; then
    fastfetch
else
    uname -a
    echo ""
    cat /etc/os-release | grep PRETTY_NAME
fi
