#!/bin/bash
# Descripción: Generador profesional de plantillas para nuevos comandos

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"
# Uso: adm sistema crear-comando <categoria> <subcomando> "<descripción>"

if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "${ROJO}Error: Faltan argumentos.${NC}"
    echo -e "Uso: ${VERDE}adm sistema crear-comando <categoria> <subcomando> [\"descripción\"]${NC}"
    echo -e "Ejemplo: adm sistema crear-comando red escanear \"Escanea la red local\""
    exit 1
fi

CATEGORIA=$1
SUBCOMANDO=$2
DESCRIPCION=${3:-"Descripción pendiente"}
ARCHIVO="adm-${CATEGORIA}-${SUBCOMANDO}.sh"
RUTA_BASE="$(dirname "$(readlink -f "$0")")"
RUTA_ARCHIVO="$RUTA_BASE/$ARCHIVO"

if [ -f "$RUTA_ARCHIVO" ]; then
    echo -e "${AMARILLO}Advertencia: El comando '$ARCHIVO' ya existe.${NC}"
    exit 1
fi

cat << 'TPL' > "$RUTA_ARCHIVO"
#!/bin/bash
# Descripción: REEMPLAZAR_DESC
# Autor: Generado por adm sistema crear-comando

# Códigos de color profesionales

mostrar_ayuda() {
    echo -e "${AZUL}Uso:${NC} adm REEMPLAZAR_CAT REEMPLAZAR_SUB [opciones]"
    echo -e "${AMARILLO}Descripción:${NC} REEMPLAZAR_DESC"
}

# Mostrar ayuda si se solicita
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    mostrar_ayuda
    exit 0
fi

echo -e "${VERDE}Ejecutando: REEMPLAZAR_DESC...${NC}"
echo -e "${AMARILLO}TODO: Inserta aquí tu lógica en Bash.${NC}"

# --- INICIO DE TU CÓDIGO ---

# --- FIN DE TU CÓDIGO ---
TPL

sed -i "s/REEMPLAZAR_DESC/$DESCRIPCION/g" "$RUTA_ARCHIVO"
sed -i "s/REEMPLAZAR_CAT/$CATEGORIA/g" "$RUTA_ARCHIVO"
sed -i "s/REEMPLAZAR_SUB/$SUBCOMANDO/g" "$RUTA_ARCHIVO"

chmod +x "$RUTA_ARCHIVO"
echo -e "${VERDE}✅ ¡Éxito! Comando creado con estructura profesional en:${NC} $RUTA_ARCHIVO"
echo -e "Ya puedes editarlo y luego usarlo ejecutando: ${AZUL}adm $CATEGORIA $SUBCOMANDO${NC}"
