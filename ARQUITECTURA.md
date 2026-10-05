# 🏗️ Arquitectura Técnica de `adm`

Este documento detalla el diseño, la estructura interna y el flujo de ejecución del framework `adm`.

---

## 🧠 Arquitectura Híbrida: Go (Cobra) + Bash ("Git Dispatcher")

El proyecto implementa un patrón **Dispatcher Modular**, combinando la velocidad, tipado y manejo de CLI de **Go** con la flexibilidad y potencia de scripting de **Bash**.

```
                         ┌────────────────────────────────┐
                         │       Usuario en Terminal      │
                         │   $ adm archivos listar -la    │
                         └───────────────┬────────────────┘
                                         │
                                         ▼
                         ┌────────────────────────────────┐
                         │   Enrutador Maestro Go (`adm`) │
                         │   (Cobra / discovery.go)       │
                         └───────────────┬────────────────┘
                                         │
                    ┌────────────────────┴────────────────────┐
                    │ Resuelve comando: adm-archivos-listar.sh│
                    │ Pasa flags intactos: -la                │
                    │ Detecta si stdout es TTY                │
                    └────────────────────┬────────────────────┘
                                         │
                                         ▼
                         ┌────────────────────────────────┐
                         │      Subcomando Bash           │
                         │  (comandos_src/adm-*.sh)       │
                         │  source lib/comun.sh           │
                         └────────────────────────────────┘
```

---

## 📁 Componentes del Sistema

### 1. Enrutador Principal en Go (`main.go` & `discovery.go`)
* **`discovery.go`**:
  * Escanea dinámicamente el directorio `comandos_src/`.
  * Filtra archivos válidos con patrón `adm-<categoria>-<subcomando>.sh` (omitiendo subcarpetas como `lib/` y archivos de backup).
  * Extrae la línea `# Descripción: ...` del encabezado para documentar el subcomando.
  * **Generador de alias únicos:** Genera atajos de una letra solo si no colisionan con otros comandos en la misma categoría (ej. evita choque entre `copiar` y `comprimir`).
* **`main.go`**:
  * Configura los comandos de Cobra con `DisableFlagParsing: true`, permitiendo que flags arbitrarios pasen sin alteración al script Bash subyacente.
  * **Detección TTY (`esTerminal`):** Imprime encabezados decorativos únicamente en terminal interactiva. Si se detecta un pipe (ej. `adm red ip-local | grep ...`), omite banners para mantener la salida limpia.
  * **Propagación de Exit Code:** Si el script hijo termina con código de salida distinto de 0, el binario `adm` sale con ese mismo código de retorno exacto.
  * **Comando especial `core`:** Permite funciones internas como `adm core actualizar` para recompilar automáticamente `adm` desde fuentes.

### 2. Biblioteca Común (`comandos_src/lib/comun.sh`)
Centraliza la lógica compartida para evitar duplicación de código en los más de 120 scripts:
* **Paleta ANSI estándar:** `ROJO`, `VERDE`, `AZUL`, `AMARILLO`, `NC`.
* **Manejo de mensajes:** `ok()`, `aviso()`, `error()`.
* **Confirmación para operaciones destructivas:** `confirmar "Mensaje"`. Soporta flag `--si` / `-y` o variable de entorno `ADM_SI=1`. Si no hay terminal interactivo ni flag `--si`, bloquea la ejecución por seguridad.
* **Comprobación de herramientas:** `requerir_cmd <binario> [paquete_apt]`.
* **Validadores:** `es_ip` y `es_entero`.

### 3. La Fábrica de Scripts (`comandos_src/`)
Cada script es una unidad autónoma con su propio ciclo de vida. Si un script tiene un error de sintaxis o falla en tiempo de ejecución, el resto del CLI permanece 100% operativo.

---

## 🗂️ Estructura del Repositorio

```text
Gestor-Comandos-CLI/
├── main.go                     # Punto de entrada de Cobra y ejecución de procesos
├── discovery.go                # Escaneo dinámico de comandos y resolución de alias
├── discovery_test.go           # Pruebas unitarias de descubrimiento y alias
├── go.mod / go.sum             # Dependencias del módulo Go
├── Makefile                    # Metas de build, test, lint, install
├── instalar_comandos.sh        # Script instalador del CLI y bash completion
├── desinstalar_comandos.sh     # Script desinstalador limpio
├── README.md                   # Documentación general de usuario
├── ARQUITECTURA.md             # Este documento
├── INSTRUCCIONES_IA.md         # Guía de estilo para agentes y LLMs
├── .github/workflows/ci.yml    # Integración continua automatizada
│
└── comandos_src/               # Directorio de scripts Bash
    ├── lib/
    │   └── comun.sh            # Librería compartida (colores, helpers, confirmación)
    ├── adm-archivos-*.sh       # Comandos de manipulación de archivos
    ├── adm-dev-*.sh            # Herramientas para desarrolladores
    ├── adm-ia-*.sh             # Utilidades de Inteligencia Artificial
    ├── adm-media-*.sh          # Procesamiento de audio/video/imágenes
    ├── adm-ollama-*.sh         # Administración de servidor y modelos Ollama
    ├── adm-procesos-*.sh       # Gestión de procesos y recursos
    ├── adm-red-*.sh            # Diagnóstico y configuración de redes
    ├── adm-seguridad-*.sh      # Seguridad, hashes y cortafuegos
    └── adm-sistema-*.sh        # Mantenimiento y estado del sistema
```

---

## 🔄 Ciclo de Vida de una Petición

1. **Invocación:** El usuario teclea `adm sistema espacio`.
2. **Descubrimiento:** `discovery.go` localiza `comandos_src/adm-sistema-espacio.sh`.
3. **Construcción de Comando:** Cobra arma el comando con categoría `sistema` y subcomando `espacio`.
4. **Ejecución del Subproceso:** Se lanza `exec.Command` hacia el script Bash pasando argumentos adicionales.
5. **Retorno:** El código de salida del script Bash se devuelve directamente a la shell del usuario.
