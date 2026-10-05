#!/bin/bash
# Descripción: Cambia la prioridad de uso de CPU (nice) de un proceso
PID=$1
NICE=$2
if [ -z "$NICE" ]; then echo "Uso: adm procesos prioridad <PID> <valor_nice (-20 a 19)>"; exit 1; fi
renice -n "$NICE" -p "$PID"
