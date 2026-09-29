#!/bin/bash
echo "📦 Instalando CLI Maestro 'adm'..."
mkdir -p ~/.local/bin

# Ahora solo instalamos el binario principal
cp /home/enoc-colomer/Documentos/Gestor-Comandos-CLI/adm ~/.local/bin/adm
chmod +x ~/.local/bin/adm

echo "✅ Instalación completada. Escribe 'adm' o 'adm ayuda' para comenzar."
