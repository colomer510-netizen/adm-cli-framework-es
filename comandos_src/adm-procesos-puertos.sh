#!/bin/bash
# Descripción: Muestra qué puertos de red está utilizando un proceso determinado
PID=$1
if [ -z "$PID" ]; then echo "Uso: adm procesos puertos <PID>"; exit 1; fi
lsof -i -P -n | grep "$PID"
