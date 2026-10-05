#!/bin/bash
# Descripción: Actualiza la lista de paquetes y programas del sistema
echo "🔄 Iniciando actualización del sistema operativo..."
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y && sudo apt clean
echo "✅ Sistema actualizado y limpio."
