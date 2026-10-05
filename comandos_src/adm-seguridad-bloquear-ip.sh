#!/bin/bash
# Descripción: Bloquea una dirección IP usando el firewall del sistema (UFW)
source "$(dirname "$(readlink -f "$0")")/lib/comun.sh"
parsear_si "$@"; set -- "${ARGS[@]}"
IP=$1
if [ -z "$IP" ]; then echo "Uso: adm seguridad bloquear-ip [--si] <direccion_ip>"; exit 1; fi
es_ip "$IP" || { error "Dirección IP no válida: $IP"; exit 1; }
requerir_cmd ufw
confirmar "¿Bloquear todo el tráfico desde $IP?" || { echo "Operación cancelada."; exit 1; }
sudo ufw deny from "$IP" && ok "IP $IP bloqueada en ufw."
