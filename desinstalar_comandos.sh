#!/bin/bash
echo "🗑️ Desinstalando CLI Maestro 'adm'..."
rm -f ~/.local/bin/adm
rm -f ~/.local/bin/adm-*
rm -f "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions/adm"
echo "✅ El comando 'adm' ha sido eliminado de tu sistema."
