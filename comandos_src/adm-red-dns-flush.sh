#!/bin/bash
# Descripción: Limpia la caché de resolución DNS del sistema operativo
echo -e "\033[0;33mLimpiando caché DNS (requiere permisos)\033[0m"
sudo systemd-resolve --flush-caches 2>/dev/null || sudo resolvectl flush-caches 2>/dev/null
echo -e "\033[0;32mCaché limpiada.\033[0m"
