#!/bin/bash
# Descripción: Muestra los 10 procesos que más procesador consumen

echo -e "\033[1;33mTop 10 procesos consumiendo más CPU:\033[0m"
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 11
