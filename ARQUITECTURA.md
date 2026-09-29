# 🏗️ Arquitectura del Gestor de Comandos CLI

Este documento explica el funcionamiento interno del framework `adm`.

## 🧠 El Modelo "Git" (Dispatcher Architecture)

El proyecto utiliza una arquitectura de **Enrutamiento Dinámico Modular**, inspirada fuertemente en cómo funcionan herramientas de nivel mundial como `git`, `docker` o `kubectl`.

En lugar de tener un solo archivo gigante con un menú de opciones (lo cual es difícil de mantener), el sistema funciona en dos capas:

### 1. El Enrutador Maestro (`adm`)
Es el único archivo que se expone al sistema operativo (instalado en `~/.local/bin/adm`).
Su trabajo no es ejecutar comandos, sino **analizar lo que escribes** y buscar el archivo correcto en la "fábrica" (`comandos_src/`).

Si tú escribes:
`adm sistema memoria`

El Enrutador Maestro hace lo siguiente:
1. Captura la palabra 1 (`sistema`) como la "Categoría".
2. Captura la palabra 2 (`memoria`) como el "Subcomando".
3. Une ambas palabras y busca un archivo llamado exactamente `adm-sistema-memoria.sh` dentro de `comandos_src/`.
4. Si el archivo existe, le delega el trabajo y ejecuta tu comando. Si no existe, muestra el menú de ayuda.

### 2. La Fábrica (`comandos_src/`)
Aquí es donde viven los verdaderos scripts (plugins). Al estar aislados, si un script falla, no tumba a los demás comandos.

## 📂 Árbol del Proyecto

```text
Gestor-Comandos-CLI/
│
├── adm                        (Script Enrutador Principal)
├── instalar_comandos.sh       (Instala el CLI en el PATH)
├── desinstalar_comandos.sh    (Desinstala el CLI)
├── README.md                  (Guía de uso para el usuario)
├── ARQUITECTURA.md            (Este documento técnico)
│
└── comandos_src/              (Fábrica de Plugins/Subcomandos)
    ├── adm-archivos-*.sh
    ├── adm-ia-*.sh
    └── adm-sistema-*.sh
```

## 🔄 Auto-Generación del Menú de Ayuda

Una de las características más avanzadas de esta arquitectura es que el comando `adm <categoria>` genera su menú al vuelo (On-the-fly).

El código interno hace un bucle `for` que escanea la carpeta `comandos_src/`. Por cada archivo que encuentra que empiece con `adm-categoria-`, recorta el nombre del archivo y lo imprime en pantalla como un comando disponible. 
Por eso, **nunca necesitas actualizar menús manualmente**.
