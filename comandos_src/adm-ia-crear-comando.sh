#!/bin/bash
# Descripción: Pide a la IA que programe y agregue un comando nuevo al repositorio automáticamente

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

CATEGORIA=$1
SUBCOMANDO=$2
shift 2
CONSULTA=$*

if [ -z "$CONSULTA" ]; then
    echo -e "${ROJO}Uso: adm ia crear-comando <categoria> <nombre> '<qué debe hacer>'${NC}"
    echo -e "Ejemplo: adm ia crear-comando archivos buscar-pdf 'busca todos los pdf del disco'"
    exit 1
fi

DESTINO="$SCRIPT_DIR/adm-${CATEGORIA}-${SUBCOMANDO}.sh"

if [ -f "$DESTINO" ]; then
    error "Error: El comando 'adm $CATEGORIA $SUBCOMANDO' ya existe en tu proyecto."
    exit 1
fi

if ! command -v ollama &> /dev/null; then
    error "Ollama no está instalado. Ejecuta primero: adm ia instalar"
    exit 1
fi

PROMPT="Actúa como programador experto en bash. Escribe el código bash para: $CONSULTA. REGLAS ESTRICTAS: 1. RESPONDE ÚNICAMENTE CON CÓDIGO. 2. NO pongas explicaciones. 3. NO envuelvas el texto en formato markdown ni \`\`\`bash. 4. NO escribas #!/bin/bash."

echo -e "${AZUL}🧠 La Inteligencia Artificial está programando tu código...${NC}\n"

CODIGO=$(ollama run llama3.2 "$PROMPT" | grep -v '```' | sed 's/^`//' | sed 's/`$//' | sed '/^[[:space:]]*$/d')

echo "#!/bin/bash" > "$DESTINO"
echo "# Descripción: $CONSULTA" >> "$DESTINO"
echo "# Autor: IA Llama3.2" >> "$DESTINO"
echo "" >> "$DESTINO"
echo "ROJO='\033[0;31m'; VERDE='\033[0;32m'; AMARILLO='\033[1;33m'; NC='\033[0m'" >> "$DESTINO"
echo "" >> "$DESTINO"
echo "$CODIGO" >> "$DESTINO"

chmod +x "$DESTINO"

ok "¡Magia realizada! El comando se ha programado e integrado a tu proyecto."
echo -e "Puedes ver tu nuevo comando usando: ${AMARILLO}adm $CATEGORIA ayuda${NC}"
echo -e "Para ejecutarlo escribe: ${AMARILLO}adm $CATEGORIA $SUBCOMANDO${NC}"
