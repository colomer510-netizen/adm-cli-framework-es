#!/bin/bash
# Descripción: Apaga el sistema inmediatamente (pide confirmación; usa --si para omitirla)
source "$(dirname "$(readlink -f "$0")")/lib/comun.sh"
parsear_si "$@"
aviso "Vas a apagar el sistema ahora mismo."
confirmar "¿Apagar el equipo?" || { echo "Operación cancelada."; exit 1; }
sudo shutdown now
