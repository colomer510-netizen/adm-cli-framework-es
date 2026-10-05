#!/bin/bash
# Descripción: Elimina contenedores detenidos, redes sin uso e imágenes huérfanas
echo -e "\033[0;33mLimpiando Docker (requiere permisos)\033[0m"
docker system prune -f
