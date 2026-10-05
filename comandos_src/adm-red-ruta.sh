#!/bin/bash
# Descripción: Traza la ruta de red hacia un destino o dominio
DESTINO=${1:-google.com}
echo -e "\033[0;34mTrazando ruta de red hacia $DESTINO...\033[0m"
tracepath "$DESTINO"
