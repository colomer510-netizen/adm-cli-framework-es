#!/bin/bash
# Descripción: Muestra las direcciones MAC físicas de las interfaces de red
echo -e "\033[0;34mTus direcciones MAC físicas:\033[0m"
ip link | awk '/link\/ether/ {print $2}'
