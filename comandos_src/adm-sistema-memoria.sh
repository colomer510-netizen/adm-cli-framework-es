#!/bin/bash
# Descripción: Muestra el consumo actual de la memoria RAM

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
# Llama al script original de la Bóveda
/home/enoc-colomer/Documentos/Admin-Ubuntu/Scripts_Seguros/salud_ram_cpu.sh
