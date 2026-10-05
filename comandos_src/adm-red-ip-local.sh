#!/bin/bash
# Descripción: Muestra la dirección IP local del equipo
echo "🌐 Obteniendo tu dirección IP..."
echo "IP Local (Red):"
ip -brief address show
echo ""
echo "IP Pública (Internet):"
curl -s ifconfig.me
echo ""
