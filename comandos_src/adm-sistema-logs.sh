#!/bin/bash
# Descripción: Muestra los registros (logs) del sistema
echo "📜 Mostrando los últimos errores del sistema..."
journalctl -p 3 -xb
