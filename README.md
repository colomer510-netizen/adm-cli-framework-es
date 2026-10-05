# 🛡️ Gestor de Comandos CLI (`adm`)

Un framework moderno de línea de comandos en **Go + Bash** con arquitectura modular. Este proyecto permite "españolizar" y simplificar tu terminal de Linux centralizando tareas de administración de sistema, manipulación de archivos, redes, procesos, desarrollo, multimedia y gestión de Inteligencias Artificiales mediante un comando maestro: `adm`.

---

## 🌟 Características Principales

* **Núcleo de Alto Rendimiento (Go + Cobra):** El enrutador maestro está implementado en Go, ofreciendo una ejecución ultrarrápida, autocompletado nativo y manejo seguro de procesos.
* **Modelo Modular ("Git Dispatcher"):** Cada subcomando es un script Bash independiente en `comandos_src/`. Si un comando falla, no afecta al resto.
* **Descubrimiento Dinámico de Comandos:** Nuevos scripts añadidos a `comandos_src/` se registran en los menús de ayuda de forma instantánea sin necesidad de recompilar ni tocar el código Go.
* **Transparencia Total de Flags:** Los flags y argumentos (ej. `-la`, `--opcion`, `--help`) se propagan intactos a los scripts Bash sin conflictos con el enrutador.
* **Propagación de Códigos de Salida:** Se preserva el exit code real del script ejecutado, permitiendo encadenar comandos (`&&`, `||`) y usar `adm` en pipelines.
* **Librería Común (`lib/comun.sh`):** Funciones reutilizables para manejo de colores, validación de dependencias externas (`requerir_cmd`), validación de IP y confirmación interactiva para comandos destructivos con flag `--si` / `-y`.
* **Autocompletado Inteligente:** Soporte para autocompletado en Bash generado automáticamente mediante Cobra.
* **Automatización y Tests:** `Makefile` completo para compilación, linting y tests unitarios en Go.

---

## 🚀 Instalación y Desinstalación

### Requisitos Previos
* Linux (probado en Ubuntu / Debian y derivados).
* Go 1.21+ (opcional para compilar desde fuentes; el instalador lo compila automáticamente si está presente).

### Instalación Rápida
Ejecuta el script de instalación en la raíz del proyecto:
```bash
./instalar_comandos.sh
```
O usando `make`:
```bash
make install
```

El instalador:
1. Compila el binario `adm` optimizado.
2. Crea el enlace en `~/.local/bin/adm`.
3. Registra el autocompletado en tu sesión de Bash.

### Desinstalación
Para eliminar el comando y sus autocompletados del sistema:
```bash
./desinstalar_comandos.sh
```

---

## 💻 Uso Básico

Formato general:
```bash
adm <categoría> <subcomando> [opciones]
```

### Menú de Ayuda y Categorías
```bash
adm             # Muestra la ayuda general y todas las categorías disponibles
adm <categoría> # Muestra todos los subcomandos de dicha categoría
```

### Ejemplos de Comandos Populares
* **Sistema:**
  * Espacio en disco: `adm sistema espacio`
  * Consumo de RAM y CPU: `adm sistema memoria`
  * Información del sistema: `adm sistema info`
* **Archivos:**
  * Listar con flags nativos: `adm archivos listar -la`
  * Buscar archivos grandes: `adm archivos buscar-grandes`
  * Comprimir directorio: `adm archivos comprimir mi_carpeta`
* **Red:**
  * Ver IP local y pública: `adm red ip-local` / `adm red publica`
  * Monitoreo de tráfico: `adm red monitor-trafico`
* **Procesos:**
  * Top consumidores de CPU: `adm procesos top-cpu`
  * Ver puertos en uso: `adm procesos puertos`
* **Inteligencia Artificial / Ollama:**
  * Estado de Ollama: `adm ollama estado`
  * Descargar modelo: `adm ollama descargar llama3.2`
  * Asistente interactivo: `adm ia chat`

---

## 🏗️ Cómo Crear Nuevos Comandos

Para agregar una nueva funcionalidad, crea un archivo Bash en `comandos_src/` siguiendo el patrón:
```text
comandos_src/adm-<categoria>-<subcomando>.sh
```

Asegúrate de:
1. Incluir la cabecera `# Descripción: <resumen en una línea>`.
2. Usar `source "$(dirname "$(readlink -f "$0")")/lib/comun.sh"` para colores, confirmaciones y validaciones.
3. Otorgarle permisos de ejecución: `chmod +x comandos_src/adm-<categoria>-<subcomando>.sh`.

El enrutador lo detectará inmediatamente al escribir `adm <categoria>`.

---

## 🛠️ Desarrollo y Pruebas

El proyecto cuenta con un `Makefile` para facilitar tareas de desarrollo:

```bash
make build    # Compila el binario adm
make test     # Ejecuta las pruebas unitarias de Go (discovery_test.go)
make vet      # Analiza el código Go con go vet
make lint     # Verifica la sintaxis de todos los scripts Bash y corre shellcheck si está instalado
make clean    # Limpia el binario generado
```
