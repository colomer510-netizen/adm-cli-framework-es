#!/bin/bash
echo "🗑️ Desinstalando CLI Maestro 'adm'..."
rm -f ~/.local/bin/adm
# Por si quedó alguno viejo
rm -f ~/.local/bin/adm-*
echo "✅ El comando 'adm' ha sido eliminado de tu sistema."
