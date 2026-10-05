#!/bin/bash
# Descripción: Devuelve el país, la ciudad y el ISP de una IP pública
IP=$1
if [ -z "$IP" ]; then echo "Uso: adm red detalles-ip <direccion_ip>"; exit 1; fi
curl -s "http://ip-api.com/json/$IP" | (jq . 2>/dev/null || cat)
