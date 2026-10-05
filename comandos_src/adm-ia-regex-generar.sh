#!/bin/bash
# Descripción: Escribes en lenguaje natural lo que necesitas y la IA te devuelve la Expresión Regular
PROMPT=${*}
if [ -z "$PROMPT" ]; then echo "Uso: adm ia regex-generar <descripcion>"; exit 1; fi
echo -e "\033[0;34mConsultando a Ollama...\033[0m"
ollama run llama3.2 "Genera solo la expresion regular para: $PROMPT. No des explicaciones largas, solo la regex y un pequeño ejemplo de uso."
