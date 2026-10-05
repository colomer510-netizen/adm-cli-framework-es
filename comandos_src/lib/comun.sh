#!/bin/bash
# Biblioteca común para los comandos de adm. Uso: source "$(dirname "$(readlink -f "$0")")/lib/comun.sh"

# shellcheck disable=SC2034
ROJO='\033[0;31m'; VERDE='\033[0;32m'; AZUL='\033[0;34m'; AMARILLO='\033[1;33m'; NC='\033[0m'

error() { echo -e "${ROJO}❌ $*${NC}" >&2; }
aviso() { echo -e "${AMARILLO}⚠️  $*${NC}"; }
ok()    { echo -e "${VERDE}✅ $*${NC}"; }

# Quita --si / -y de los argumentos y activa ADM_SI=1. Uso: parsear_si "$@"; set -- "${ARGS[@]}"
parsear_si() {
    ARGS=()
    local a
    for a in "$@"; do
        if [[ "$a" == "--si" || "$a" == "-y" ]]; then ADM_SI=1; else ARGS+=("$a"); fi
    done
}

# Pide confirmación. Devuelve 0 si el usuario acepta o si ADM_SI=1.
# Sin terminal interactivo y sin ADM_SI, deniega por seguridad.
confirmar() {
    local msg="${1:-¿Continuar?}" resp
    [[ "$ADM_SI" == "1" ]] && return 0
    if [[ ! -t 0 ]]; then
        error "Se requiere confirmación interactiva (usa --si para omitirla)."
        return 1
    fi
    read -r -p "$(echo -e "${AMARILLO}${msg} (s/n): ${NC}")" resp
    [[ "$resp" =~ ^([sS]|[sS][iI]|[yY])$ ]]
}

# Verifica que exista un programa externo.
requerir_cmd() {
    command -v "$1" >/dev/null 2>&1 || { error "Falta la dependencia: $1 (instálala con: sudo apt install ${2:-$1})"; exit 1; }
}

es_entero() { [[ "$1" =~ ^[0-9]+$ ]]; }

es_ip() {
    local ip="$1" o
    if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}(/[0-9]{1,2})?$ ]]; then
        IFS=. read -r -a o <<< "${ip%%/*}"
        for n in "${o[@]}"; do (( n <= 255 )) || return 1; done
        return 0
    fi
    [[ "$ip" =~ ^[0-9a-fA-F:]+(/[0-9]{1,3})?$ && "$ip" == *:* ]]
}
