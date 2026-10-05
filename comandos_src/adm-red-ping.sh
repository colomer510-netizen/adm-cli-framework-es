#!/bin/bash
# Descripción: Hace un ping a un servidor para comprobar la conexión
URL=${1:-google.com}
echo "📡 Comprobando conexión con $URL..."
ping -c 4 "$URL"
