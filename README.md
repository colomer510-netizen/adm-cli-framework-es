# 🛡️ Gestor de Comandos CLI (adm)

Un framework de línea de comandos en Bash con arquitectura modular. Este proyecto permite "españolizar" tu terminal de Linux centralizando tareas de sistema, manipulación de archivos y gestión de Inteligencias Artificiales mediante un solo comando maestro: `adm`.

---

## 🌟 Características
* **Modelo "Git":** Arquitectura modular dinámica. El enrutador principal lee los argumentos y lanza sub-scripts independientes.
* **Menús Automáticos:** Si agregas un nuevo script, el menú de ayuda se actualiza solo sin tocar el código central.
* **Comandos en Español:** Todos los comandos de Linux traducidos y agrupados bajo categorías lógicas (`sistema`, `archivos`, `ia`).
* **Seguro y Aislado:** Funciona como un CLI profesional usando `~/.local/bin/`.

---

## 🚀 Instalación
Para instalar el sistema de comandos en tu computadora:

1. Abre tu terminal.
2. Navega hasta esta carpeta.
3. Ejecuta el instalador:
   ```bash
   ./instalar_comandos.sh
   ```
El instalador creará un enlace del script principal `adm` en `~/.local/bin/adm`.

Para desinstalarlo en cualquier momento, ejecuta:
```bash
./desinstalar_comandos.sh
```

---

## 💻 Uso Básico

El uso general sigue el formato: `adm <categoría> <subcomando> [argumentos]`

### Menú de Ayuda
```bash
adm
# o
adm ayuda
```

### Ejemplos de uso
* Ver el espacio del disco: `adm sistema espacio`
* Ver procesos de RAM/CPU: `adm sistema memoria`
* Copiar un archivo: `adm archivos copiar archivo1.txt /destino`
* Abrir el gestor de Llama: `adm ia llama`

---

## 🏗️ Agregar nuevos comandos
Para añadir un nuevo comando, simplemente crea un script bash en la carpeta `comandos_src/` siguiendo esta nomenclatura:
`adm-<categoria>-<nombre_comando>.sh`

El archivo maestro lo detectará automáticamente y estará listo para usarse. 

*Consulta el archivo **ARQUITECTURA.md** para más información sobre cómo funciona internamente.*
