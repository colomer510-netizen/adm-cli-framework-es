#!/bin/bash
# Descripción: Programa el apagado del sistema en la cantidad de minutos especificada
source "$(dirname "$(readlink -f "$0")")/lib/comun.sh"
MINUTOS=$1
if [ -z "$MINUTOS" ]; then echo "Uso: adm sistema programar-apagado <minutos>"; exit 1; fi
es_entero "$MINUTOS" || { error "Los minutos deben ser un número entero."; exit 1; }
sudo shutdown +"$MINUTOS" && ok "El equipo se apagará en $MINUTOS minutos."
