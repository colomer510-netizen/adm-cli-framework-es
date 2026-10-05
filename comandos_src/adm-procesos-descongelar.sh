#!/bin/bash
# Descripción: Reanuda la ejecución de un proceso congelado mediante su PID
PID=${1}
if [ -z "$PID" ]; then echo -e "\033[0;31mUso: adm procesos descongelar <PID>\033[0m"; exit 1; fi
kill -CONT $PID && echo -e "\033[0;32m✅ Proceso $PID reanudado.\033[0m"
