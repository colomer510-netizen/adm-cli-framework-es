package main

import (
	"bufio"
	"os"
	"path/filepath"
	"sort"
	"strings"
	"unicode/utf8"
)

// CmdInfo describe un script descubierto en comandos_src.
type CmdInfo struct {
	Cat  string
	Name string
	Desc string
	Path string
}

// parseScriptName extrae categoría y subcomando de "adm-<cat>-<sub>.sh".
func parseScriptName(fileName string) (cat, sub string, ok bool) {
	if !strings.HasPrefix(fileName, "adm-") || !strings.HasSuffix(fileName, ".sh") {
		return "", "", false
	}
	trim := strings.TrimSuffix(strings.TrimPrefix(fileName, "adm-"), ".sh")
	parts := strings.SplitN(trim, "-", 2)
	if len(parts) != 2 || parts[0] == "" || parts[1] == "" {
		return "", "", false
	}
	return parts[0], parts[1], true
}

// discoverCommands lee el directorio y devuelve los comandos ordenados.
func discoverCommands(dir string) []CmdInfo {
	entries, err := os.ReadDir(dir)
	if err != nil {
		return nil
	}
	var cmds []CmdInfo
	for _, e := range entries {
		if e.IsDir() {
			continue
		}
		cat, sub, ok := parseScriptName(e.Name())
		if !ok {
			continue
		}
		path := filepath.Join(dir, e.Name())
		desc := extractDescription(path)
		if desc == "" {
			desc = "Ejecutar comando " + sub
		}
		cmds = append(cmds, CmdInfo{Cat: cat, Name: sub, Desc: desc, Path: path})
	}
	sort.Slice(cmds, func(i, j int) bool {
		if cmds[i].Cat != cmds[j].Cat {
			return cmds[i].Cat < cmds[j].Cat
		}
		return cmds[i].Name < cmds[j].Name
	})
	return cmds
}

// extractDescription devuelve el texto de la línea "# Descripción: ...".
func extractDescription(path string) string {
	file, err := os.Open(path)
	if err != nil {
		return ""
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "# Descripción:") {
			return strings.TrimSpace(strings.TrimPrefix(line, "# Descripción:"))
		}
	}
	return ""
}

// uniqueAliases asigna como alias la primera letra de cada nombre, pero solo
// cuando es única entre los hermanos, no coincide con ningún nombre completo
// y no está en `reserved`. Devuelve un mapa nombre -> alias.
func uniqueAliases(names []string, reserved map[string]bool) map[string]string {
	first := func(s string) string {
		r, size := utf8.DecodeRuneInString(s)
		if r == utf8.RuneError {
			return ""
		}
		return s[:size]
	}
	count := make(map[string]int)
	full := make(map[string]bool, len(names))
	for _, n := range names {
		count[first(n)]++
		full[n] = true
	}
	res := make(map[string]string)
	for _, n := range names {
		a := first(n)
		if a != "" && count[a] == 1 && !reserved[a] && !full[a] {
			res[n] = a
		}
	}
	return res
}

func getCategoryDesc(cat string) string {
	switch cat {
	case "sistema":
		return "Diagnóstico, recursos y estado."
	case "archivos":
		return "Navegación y manipulación de archivos."
	case "ia":
		return "Gestión de Inteligencias Artificiales."
	case "red":
		return "Conectividad, puertos y herramientas de red."
	case "procesos":
		return "Búsqueda, listado y gestión de programas."
	case "dev":
		return "Herramientas para desarrolladores (Git, Node...)."
	case "media":
		return "Herramientas multimedia (Video, Imagen)."
	case "seguridad":
		return "Antivirus, contraseñas y auditoría."
	case "docker":
		return "Gestión de contenedores Docker."
	case "ollama":
		return "Gestión de modelos y servidor Ollama."
	default:
		return "Comandos de " + cat
	}
}
