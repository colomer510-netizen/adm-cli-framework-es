#!/bin/bash
# Descripción: Programa en cuántos minutos quieres que la máquina se reinicie sola
source "$(dirname "$(readlink -f "$0")")/lib/comun.sh"
MINUTOS=$1
if [ -z "$MINUTOS" ]; then echo "Uso: adm sistema programar-reinicio <minutos>"; exit 1; fi
es_entero "$MINUTOS" || { error "Los minutos deben ser un número entero."; exit 1; }
sudo shutdown -r +"$MINUTOS" && ok "Reinicio programado en $MINUTOS minutos."
