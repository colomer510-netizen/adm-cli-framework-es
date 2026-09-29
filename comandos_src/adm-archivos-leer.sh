#!/bin/bash
if [ -z "$1" ]; then
    echo "❌ Uso correcto: adm-leer <archivo>"
    exit 1
fi
cat "$1"
