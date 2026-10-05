#!/bin/bash
# Descripción: Muestra los 10 procesos que más memoria RAM consumen

echo -e "\033[1;33mTop 10 procesos consumiendo más RAM:\033[0m"
ps -eo pid,user,%mem,%cpu,comm --sort=-%mem | head -n 11
