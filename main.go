package main

import (
	"errors"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"

	"github.com/spf13/cobra"
)

const separador = "════════════════════════════════════════════════════════════"

// esTerminal indica si stdout es un terminal interactivo. Si no lo es (pipe,
// redirección) o ADM_PLAIN está definido, no se imprimen adornos.
func esTerminal() bool {
	if os.Getenv("ADM_PLAIN") != "" {
		return false
	}
	fi, err := os.Stdout.Stat()
	return err == nil && fi.Mode()&os.ModeCharDevice != 0
}

// resolverDirs devuelve el directorio del proyecto y el de comandos.
// ADM_HOME permite sobreescribir la ubicación.
func resolverDirs() (string, string) {
	if home := os.Getenv("ADM_HOME"); home != "" {
		return home, filepath.Join(home, "comandos_src")
	}
	execPath, err := os.Executable()
	if err != nil {
		fmt.Fprintln(os.Stderr, "Error obteniendo ejecutable:", err)
		os.Exit(1)
	}
	realPath, err := filepath.EvalSymlinks(execPath)
	if err != nil {
		realPath = execPath
	}
	dir := filepath.Dir(realPath)
	return dir, filepath.Join(dir, "comandos_src")
}

func main() {
	rootCmd := &cobra.Command{
		Use:           "adm",
		Short:         "🛡️ CLI MAESTRO: ADMIN-UBUNTU (adm)",
		Long:          "Un framework de línea de comandos escrito en Go con arquitectura modular dinámica.",
		SilenceErrors: true,
		SilenceUsage:  true,
	}

	scriptDir, comandosDir := resolverDirs()
	allCmds := discoverCommands(comandosDir)

	// Agrupar por categoría manteniendo el orden.
	var catOrder []string
	byCat := make(map[string][]CmdInfo)
	for _, c := range allCmds {
		if _, ok := byCat[c.Cat]; !ok {
			catOrder = append(catOrder, c.Cat)
		}
		byCat[c.Cat] = append(byCat[c.Cat], c)
	}

	// Alias de una letra solo cuando son únicos (core usa "c").
	catAliases := uniqueAliases(catOrder, map[string]bool{"c": true, "b": true, "h": true})

	for _, catName := range catOrder {
		catCmd := &cobra.Command{
			Use:   catName,
			Short: getCategoryDesc(catName),
			Run:   func(cmd *cobra.Command, args []string) { cmd.Help() },
		}
		if a, ok := catAliases[catName]; ok {
			catCmd.Aliases = []string{a}
		}

		subNames := make([]string, 0, len(byCat[catName]))
		for _, c := range byCat[catName] {
			subNames = append(subNames, c.Name)
		}
		subAliases := uniqueAliases(subNames, nil)

		for _, c := range byCat[catName] {
			c := c
			subCmd := &cobra.Command{
				Use:                c.Name,
				Short:              c.Desc,
				DisableFlagParsing: true, // los flags se pasan tal cual al script
				RunE: func(cmd *cobra.Command, args []string) error {
					// La ayuda la gestiona adm: así nunca se ejecuta un script solo para pedir ayuda.
					if len(args) > 0 && (args[0] == "-h" || args[0] == "--help" || args[0] == "--ayuda") {
						fmt.Printf("Uso: adm %s %s [argumentos]\n%s\n", c.Cat, c.Name, c.Desc)
						return nil
					}
					decorar := esTerminal()
					if decorar {
						title := fmt.Sprintf("EJECUTANDO: adm %s %s", c.Cat, c.Name)
						fmt.Printf("\n\033[1;36m%s\033[0m\n", separador)
						fmt.Printf(" ⚡ \033[1;33m%s\033[0m\n", title)
						fmt.Printf("\033[1;36m%s\033[0m\n\n", strings.ReplaceAll(separador, "═", "─"))
					}

					execCmd := exec.Command("bash", append([]string{c.Path}, args...)...)
					execCmd.Stdout = os.Stdout
					execCmd.Stderr = os.Stderr
					execCmd.Stdin = os.Stdin
					err := execCmd.Run()

					if decorar {
						fmt.Printf("\n\033[1;36m%s\033[0m\n\n", separador)
					}
					return err
				},
			}
			if a, ok := subAliases[c.Name]; ok {
				subCmd.Aliases = []string{a}
			}
			catCmd.AddCommand(subCmd)
		}
		rootCmd.AddCommand(catCmd)
	}

	// 💡 OPCIÓN 2: COMANDO BUSCAR
	searchCmd := &cobra.Command{
		Use:   "buscar [palabra]",
		Short: "🔍 Busca rápidamente entre todos los comandos disponibles",
		Args:  cobra.ExactArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			term := strings.ToLower(args[0])
			fmt.Printf("\n\033[1;36m🔍 Buscando '%s' en el sistema...\033[0m\n", term)
			fmt.Println("\033[1;34m────────────────────────────────────────────────────────────\033[0m")
			encontrado := false
			for _, c := range allCmds {
				if strings.Contains(strings.ToLower(c.Name), term) || strings.Contains(strings.ToLower(c.Desc), term) || strings.Contains(strings.ToLower(c.Cat), term) {
					fmt.Printf("  \033[1;32madm %-10s %-16s\033[0m : %s\n", c.Cat, c.Name, c.Desc)
					encontrado = true
				}
			}
			if !encontrado {
				fmt.Println("\033[1;31m  No se encontraron comandos relacionados.\033[0m")
			}
			fmt.Print("\033[1;34m────────────────────────────────────────────────────────────\033[0m\n\n")
		},
	}
	rootCmd.AddCommand(searchCmd)

	// 💡 OPCIÓN 5: ACTUALIZADOR CORE
	coreCmd := &cobra.Command{
		Use:     "core",
		Aliases: []string{"c"},
		Short:   "⚙️  Mantenimiento del propio framework adm",
	}
	updateCmd := &cobra.Command{
		Use:     "actualizar",
		Aliases: []string{"a"},
		Short:   "Descarga la última versión, recompila y actualiza el binario",
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Println("\033[1;36m🔄 Actualizando el núcleo de adm...\033[0m")

			// 1. git pull
			execCmd := exec.Command("git", "pull")
			execCmd.Dir = scriptDir
			execCmd.Stdout = os.Stdout
			execCmd.Stderr = os.Stderr
			execCmd.Run()

			// 2. go build
			fmt.Println("\033[1;33m🔨 Recompilando el motor Go...\033[0m")
			buildCmd := exec.Command("go", "build", "-o", "adm", ".")
			buildCmd.Dir = scriptDir
			buildCmd.Stdout = os.Stdout
			buildCmd.Stderr = os.Stderr
			err := buildCmd.Run()

			if err == nil {
				fmt.Println("\033[1;32m✅ Framework adm actualizado exitosamente.\033[0m")
			} else {
				fmt.Println("\033[1;31m❌ Error recompilando el motor.\033[0m")
			}
		},
	}
	coreCmd.AddCommand(updateCmd)
	rootCmd.AddCommand(coreCmd)

	rootCmd.InitDefaultHelpCmd()
	helpCmd, _, _ := rootCmd.Find([]string{"help"})
	if helpCmd != nil {
		helpCmd.Short = "Muestra la ayuda para cualquier comando"
	}

	rootCmd.InitDefaultCompletionCmd()
	compCmd, _, _ := rootCmd.Find([]string{"completion"})
	if compCmd != nil {
		compCmd.Short = "Genera el script de autocompletado para tu terminal"
	}

	// 💡 OPCIÓN 3: COLORES REALES EN EL MENÚ
	// Plantilla con códigos ANSI integrados (\033[1;34m = Azul, \033[1;32m = Verde, \033[0m = Reset)
	rootCmd.SetUsageTemplate(`{{if not .HasParent}}{{"\033[1;34m"}}============================================={{"\033[0m"}}
   🛡️ {{"\033[1;36m"}}CLI MAESTRO: ADMIN-UBUNTU (adm){{"\033[0m"}}
{{"\033[1;34m"}}============================================={{"\033[0m"}}
{{"\033[1;33m"}}Uso:{{"\033[0m"}} adm <categoría> <subcomando> [argumentos]

{{"\033[1;33m"}}Categorías disponibles:{{"\033[0m"}}{{range .Commands}}{{if (or .IsAvailableCommand (eq .Name "help"))}}
  🔹 {{"\033[1;32m"}}{{rpad .Name 10}}{{"\033[0m"}} : {{.Short}}{{end}}{{end}}

Para ver los subcomandos de una categoría, escribe:
  {{"\033[1;32m"}}adm <categoría>{{"\033[0m"}} (Ejemplo: adm sistema)
{{"\033[1;34m"}}============================================={{"\033[0m"}}{{else}}{{"\033[1;34m"}}============================================={{"\033[0m"}}
   📁 {{"\033[1;36m"}}CATEGORÍA: {{.Name}}{{"\033[0m"}}
{{"\033[1;34m"}}============================================={{"\033[0m"}}
{{"\033[1;33m"}}Subcomandos disponibles:{{"\033[0m"}}{{$catName := .Name}}{{range .Commands}}{{if (or .IsAvailableCommand (eq .Name "help"))}}
  🔸 {{"\033[1;36m"}}adm {{$catName | printf "%-10s"}}{{"\033[0m"}} {{"\033[1;32m"}}{{rpad .Name 16}}{{"\033[0m"}} : {{.Short}}{{end}}{{end}}
{{"\033[1;34m"}}============================================={{"\033[0m"}}{{end}}{{if .HasAvailableLocalFlags}}

{{"\033[1;33m"}}Banderas disponibles:{{"\033[0m"}}
{{.LocalFlags.FlagUsages | trimTrailingWhitespaces}}{{end}}
`)

	rootCmd.SetHelpTemplate(rootCmd.UsageTemplate())

	if err := rootCmd.Execute(); err != nil {
		var exitErr *exec.ExitError
		if errors.As(err, &exitErr) {
			// El script ya mostró su propio error; propagamos su código de salida.
			os.Exit(exitErr.ExitCode())
		}
		fmt.Fprintln(os.Stderr, "Error:", err)
		os.Exit(1)
	}
}
