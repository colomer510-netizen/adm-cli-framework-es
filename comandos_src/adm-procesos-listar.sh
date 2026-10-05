#!/bin/bash
# Descripción: Muestra una lista de todos los procesos activos
echo "📊 Mostrando procesos..."
if command -v htop &> /dev/null; then
    htop
else
    top
fi
