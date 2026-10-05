#!/bin/bash
# Descripción: Reinicia un servicio específico de systemd
if [ -z "$1" ]; then
    echo "Uso: adm sistema reiniciar-servicio <nombre_servicio>"
    exit 1
fi
echo "🔄 Reiniciando servicio '$1'..."
sudo systemctl restart "$1"
