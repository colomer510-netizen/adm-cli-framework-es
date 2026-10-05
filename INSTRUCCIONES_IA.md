# 🤖 INSTRUCCIONES PARA IA (Asistentes de Código / LLMs)

¡Hola, colega IA! Si estás asistiendo al usuario para crear o modificar comandos en este proyecto, sigue **ESTRICTAMENTE** estas directrices para preservar la arquitectura y la estabilidad del sistema.

---

## 1. Arquitectura del Repositorio
* El ejecutable maestro es un binario compilado en Go (`adm`) basado en Cobra (`main.go` + `discovery.go`).
* Todos los scripts operativos se alojan en `comandos_src/`.
* Los scripts deben seguir **ESTRICTAMENTE** la convención:
  ```text
  comandos_src/adm-<categoria>-<subcomando>.sh
  ```
* El enrutador Go lee dinámicamente el directorio `comandos_src/`. **NUNCA** modifiques `main.go` ni `discovery.go` para añadir un comando nuevo; se auto-descubre en tiempo de ejecución.

---

## 2. Reglas para Crear Nuevos Comandos

### Plantilla Estándar Obligatoria:
Todo nuevo script Bash debe crearse con esta estructura:

```bash
#!/bin/bash
# Descripción: Breve resumen de una línea de la función del comando.

# Cargar biblioteca común
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
source "$SCRIPT_DIR/lib/comun.sh"

# Verificar dependencias si aplica (ej. jq, curl, ffmpeg)
requerir_cmd "jq" "jq"

# Ayuda contextual
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo -e "${AZUL}Uso:${NC} adm <categoria> <subcomando> [opciones]"
    exit 0
fi

# Si el comando es destructivo o de alto riesgo, pide confirmación:
parsear_si "$@"
set -- "${ARGS[@]}"
confirmar "¿Estás seguro de ejecutar esta acción?" || exit 1

# Lógica del script
ok "Acción completada con éxito."
```

---

## 3. Principios Críticos de Calidad

1. **Línea de Descripción:** La línea 2 **DEBE** ser `# Descripción: ...`. `discovery.go` extrae este texto para la ayuda del CLI.
2. **Uso de `lib/comun.sh`:** Utiliza siempre los helpers de `lib/comun.sh` (`ok`, `aviso`, `error`, `confirmar`, `requerir_cmd`, `es_ip`). No reinventes funciones de color ni de confirmación.
3. **Manejo de argumentos:** Siempre entrecomilla variables (`"$1"`, `"$target"`) para evitar fallos con rutas o nombres que contengan espacios.
4. **Comandos destructivos:** Usa siempre `confirmar` para apagados, eliminación masiva de archivos o bloqueos de red. Soporta el flag `--si` mediante `parsear_si`.
5. **Permisos de ejecución:** Asegúrate de que el archivo tenga permisos `chmod +x` (755).
6. **Pruebas y Verificación:** Antes de concluir tu tarea, ejecuta `make lint` y `make test` para verificar que la sintaxis de todos los scripts y el código Go estén impecables.
