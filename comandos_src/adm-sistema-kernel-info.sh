#!/bin/bash
# Descripción: Muestra la versión del kernel y los módulos cargados
echo -e "\033[0;32mVersión del Kernel:\033[0m"
uname -r
echo -e "\033[0;34mMódulos cargados (top 15):\033[0m"
lsmod | head -n 15
