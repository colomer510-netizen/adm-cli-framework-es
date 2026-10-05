#!/bin/bash
# Descripción: Muestra cuánto tiempo lleva ejecutándose un proceso
PID=$1
if [ -z "$PID" ]; then echo "Uso: adm procesos tiempo-uso <PID>"; exit 1; fi
ps -p "$PID" -o pid,etime,cmd
