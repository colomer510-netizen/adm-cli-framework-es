#!/bin/bash
# Descripción: Comprueba qué herramientas externas necesita adm y cuáles faltan

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║         🩺 adm doctor — Diagnóstico del sistema          ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ─── Herramientas requeridas por los comandos de adm ─────────────────────────
# Formato: "binario|paquete_apt|categoria|descripcion"
HERRAMIENTAS=(
  "git|git|dev|Control de versiones (adm dev git-*)"
  "jq|jq|dev|Procesador JSON (adm dev json-formatear)"
  "docker|docker.io|dev|Contenedores (adm dev docker-limpiar)"
  "curl|curl|red|Transferencias HTTP (adm dev test-api)"
  "zip|zip|archivos|Comprimir con contraseña (adm archivos zip-clave)"
  "ffmpeg|ffmpeg|media|Video y audio (adm media comprimir-video, extraer-audio, crear-gif)"
  "ffprobe|ffmpeg|media|Información multimedia (adm media info)"
  "convert|imagemagick|media|Imágenes (adm media convertir-imagen, redimensionar)"
  "nmap|nmap|red|Escáner de red (adm red escanear-lan)"
  "nethogs|nethogs|red|Monitor de tráfico (adm red monitor-trafico)"
  "speedtest-cli|speedtest-cli|red|Test de velocidad (adm red test-velocidad)"
  "ufw|ufw|seguridad|Cortafuegos (adm seguridad bloquear-ip, adm red cortafuegos)"
  "clamscan|clamav|seguridad|Antivirus (adm seguridad antivirus)"
  "rkhunter|rkhunter|seguridad|Detector de rootkits (adm seguridad chequear-rootkits)"
  "ollama|ollama|ia|Motor de IA local (todos los comandos adm ia y adm ollama)"
  "shellcheck|shellcheck|desarrollo|Linting de scripts Bash (make lint)"
  "bats|bats|desarrollo|Tests de scripts Bash (make test-bash)"
  "go|golang|core|Compilador Go para adm core actualizar"
)

TOTAL=0
OK=0
FALTA=0

FALTANTES=()

for entry in "${HERRAMIENTAS[@]}"; do
  IFS='|' read -r bin pkg cat desc <<< "$entry"
  TOTAL=$((TOTAL + 1))
  if command -v "$bin" > /dev/null 2>&1; then
    version=$(command -v "$bin" > /dev/null && "$bin" --version 2>/dev/null | head -1 | cut -c1-50 || echo "instalado")
    printf "  ${VERDE}✅ %-16s${NC} %-12s %s\n" "$bin" "[$cat]" "$desc"
    OK=$((OK + 1))
  else
    printf "  ${ROJO}❌ %-16s${NC} %-12s %s\n" "$bin" "[$cat]" "$desc"
    FALTA=$((FALTA + 1))
    FALTANTES+=("$bin|$pkg")
  fi
done

echo ""
echo "────────────────────────────────────────────────────────────"
printf "  Total: ${TOTAL}  ${VERDE}Instaladas: ${OK}${NC}  ${ROJO}Faltantes: ${FALTA}${NC}\n"
echo "────────────────────────────────────────────────────────────"

# ─── Instalar lo que falta ────────────────────────────────────────────────────
if [ "${FALTA}" -gt 0 ]; then
  echo ""
  aviso "Algunas herramientas no están instaladas."
  echo ""
  echo "  Para instalar las que faltan, ejecuta:"
  echo ""

  # Agrupar paquetes apt (excluyendo ollama y go que tienen instaladores propios)
  APT_PKGS=()
  MANUAL=()
  for entry in "${FALTANTES[@]}"; do
    IFS='|' read -r bin pkg <<< "$entry"
    case "$bin" in
      ollama)
        MANUAL+=("ollama → curl -fsSL https://ollama.com/install.sh | sh")
        ;;
      go)
        MANUAL+=("go     → sudo apt install golang  (o visita https://go.dev/dl/)")
        ;;
      bats)
        MANUAL+=("bats   → sudo apt install bats  (o: npm install -g bats)")
        ;;
      *)
        # Evitar duplicados de paquete
        if [[ ! " ${APT_PKGS[*]} " =~ " ${pkg} " ]]; then
          APT_PKGS+=("$pkg")
        fi
        ;;
    esac
  done

  if [ "${#APT_PKGS[@]}" -gt 0 ]; then
    echo -e "  ${AZUL}sudo apt install -y ${APT_PKGS[*]}${NC}"
  fi
  for m in "${MANUAL[@]}"; do
    echo -e "  ${AZUL}${m}${NC}"
  done
  echo ""
fi

# ─── Estado de adm mismo ──────────────────────────────────────────────────────
echo ""
echo "  📦 Estado del CLI adm:"
ADM_BIN=$(command -v adm 2>/dev/null || echo "")
if [ -n "$ADM_BIN" ]; then
  ok "adm está instalado en: $ADM_BIN"
else
  aviso "adm no está en tu PATH. Ejecuta: ./instalar_comandos.sh"
fi

SCRIPTS_COUNT=$(ls "$SCRIPT_DIR"/adm-*.sh 2>/dev/null | wc -l)
ok "${SCRIPTS_COUNT} scripts detectados en comandos_src/"
echo ""
