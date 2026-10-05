#!/bin/bash
# Descripción: Muestra información de la batería (si es un portátil)

echo -e "\033[0;34mInformación de la batería:\033[0m"
upower -i $(upower -e | grep 'BAT') 2>/dev/null | grep -E "state|to\ full|to\ empty|percentage|capacity" || echo "No se encontró batería en este equipo."
