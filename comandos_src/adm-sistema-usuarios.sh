#!/bin/bash
# Descripción: Lista los usuarios registrados en el sistema
echo "👥 Usuarios del sistema:"
cut -d: -f1 /etc/passwd
