#!/bin/bash
# Descripción: Ejecuta un test rápido de velocidad de descarga y subida
if command -v speedtest-cli &> /dev/null; then
    speedtest-cli
else
    echo "Necesitas instalar speedtest-cli. Ejecuta: sudo apt install speedtest-cli"
fi
