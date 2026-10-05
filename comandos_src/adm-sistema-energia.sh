#!/bin/bash
# Descripción: Configuración de energía y comportamiento al cerrar tapa

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

echo "============================================="
echo "   ⚡ CONFIGURACIÓN DE ENERGÍA (Modo Servidor)"
echo "============================================="
echo "¿Qué deseas hacer con el portátil al cerrar la tapa?"
echo "1) Activar Modo Servidor (La PC NO se suspenderá al cerrar la tapa)"
echo "2) Desactivar Modo Servidor (La PC se suspenderá al cerrar la tapa - Normal)"
echo "3) Ver estado actual (Saber si el modo servidor está activo)"
echo "4) Salir"
echo "============================================="

read -r -p "Elige una opción (1-4): " opcion

case $opcion in
    1)
        echo "Activando Modo Servidor..."
        gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'nothing'
        gsettings set org.gnome.settings-daemon.plugins.power lid-close-battery-action 'nothing'
        echo "✅ ¡Listo! Puedes cerrar la tapa, la pantalla se apagará pero los servicios seguirán funcionando."
        ;;
    2)
        echo "Restaurando configuración de fábrica..."
        gsettings reset org.gnome.settings-daemon.plugins.power lid-close-ac-action
        gsettings reset org.gnome.settings-daemon.plugins.power lid-close-battery-action
        echo "✅ ¡Listo! El portátil volverá a suspenderse al cerrar la tapa."
        ;;
    3)
        echo "Consultando estado actual..."
        ESTADO=$(gsettings get org.gnome.settings-daemon.plugins.power lid-close-ac-action)
        if [ "$ESTADO" = "'nothing'" ]; then
            echo "ℹ️  ESTADO ACTUAL: MODO SERVIDOR ACTIVADO (No se suspende)"
        else
            echo "ℹ️  ESTADO ACTUAL: NORMAL (Sí se suspende al cerrar)"
        fi
        ;;
    4)
        echo "Saliendo..."
        exit 0
        ;;
    *)
        echo "❌ Opción no válida."
        exit 1
        ;;
esac
