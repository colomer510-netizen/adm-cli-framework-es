#!/bin/bash
# Descripción: Muestra en tiempo real el tráfico de red de tu máquina
if command -v iftop &> /dev/null; then
    sudo iftop
elif command -v nload &> /dev/null; then
    nload
else
    echo "Instala nload o iftop: sudo apt install nload"
fi
