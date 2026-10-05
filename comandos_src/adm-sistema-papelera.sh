#!/bin/bash
# Descripción: Vacía la papelera de reciclaje del sistema (pide confirmación)
source "$(dirname "$(readlink -f "$0")")/lib/comun.sh"
parsear_si "$@"
confirmar "Se borrará permanentemente todo el contenido de la papelera. ¿Continuar?" || { echo "Operación cancelada."; exit 1; }
rm -rf ~/.local/share/Trash/files/* ~/.local/share/Trash/info/* 2>/dev/null
ok "Papelera vaciada correctamente."
