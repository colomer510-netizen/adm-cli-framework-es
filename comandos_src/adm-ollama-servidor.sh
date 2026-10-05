#!/bin/bash
# Descripción: Muestra el estado del servicio en segundo plano de Ollama (systemctl)

echo -e "\033[1;36m⚙️ Estado del motor de IA (Servicio Ollama):\033[0m"
systemctl status ollama --no-pager | head -n 10
