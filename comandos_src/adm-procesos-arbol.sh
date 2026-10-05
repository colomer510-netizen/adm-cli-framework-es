#!/bin/bash
# Descripción: Muestra visualmente la jerarquía de procesos
if command -v pstree &> /dev/null; then
    pstree -p
else
    ps -ejH
fi
