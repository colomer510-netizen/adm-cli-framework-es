package main

import (
	"os"
	"path/filepath"
	"testing"
)

func TestParseScriptName(t *testing.T) {
	casos := []struct {
		in, cat, sub string
		ok           bool
	}{
		{"adm-sistema-info.sh", "sistema", "info", true},
		{"adm-red-ip-local.sh", "red", "ip-local", true},
		{"adm-solo.sh", "", "", false},
		{"otro-sistema-info.sh", "", "", false},
		{"adm-ia-chat.sh.bak", "", "", false},
		{"adm--x.sh", "", "", false},
	}
	for _, c := range casos {
		cat, sub, ok := parseScriptName(c.in)
		if cat != c.cat || sub != c.sub || ok != c.ok {
			t.Errorf("%s: got (%q,%q,%v)", c.in, cat, sub, ok)
		}
	}
}

func TestUniqueAliases(t *testing.T) {
	res := uniqueAliases([]string{"copiar", "comprimir", "mover", "b"}, map[string]bool{"m": true})
	if _, ok := res["copiar"]; ok {
		t.Error("copiar no debe tener alias (choca con comprimir)")
	}
	if _, ok := res["mover"]; ok {
		t.Error("mover no debe usar un alias reservado")
	}
	if _, ok := res["b"]; ok {
		t.Error("un nombre de una letra no necesita alias")
	}
	res = uniqueAliases([]string{"memoria", "info"}, nil)
	if res["memoria"] != "m" || res["info"] != "i" {
		t.Errorf("alias inesperados: %v", res)
	}
}

func TestDiscoverCommands(t *testing.T) {
	dir := t.TempDir()
	os.WriteFile(filepath.Join(dir, "adm-a-uno.sh"), []byte("#!/bin/bash\n# Descripción: Hace uno\n"), 0o755)
	os.WriteFile(filepath.Join(dir, "adm-a-dos.sh"), []byte("#!/bin/bash\n"), 0o755)
	os.WriteFile(filepath.Join(dir, "ignorar.sh"), []byte("x"), 0o755)
	os.Mkdir(filepath.Join(dir, "lib"), 0o755)

	cmds := discoverCommands(dir)
	if len(cmds) != 2 {
		t.Fatalf("esperaba 2 comandos, obtuve %d", len(cmds))
	}
	if cmds[0].Name != "dos" || cmds[0].Desc != "Ejecutar comando dos" {
		t.Errorf("inesperado: %+v", cmds[0])
	}
	if cmds[1].Desc != "Hace uno" {
		t.Errorf("inesperado: %+v", cmds[1])
	}
}
