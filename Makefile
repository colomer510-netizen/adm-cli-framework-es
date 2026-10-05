.PHONY: build test vet lint install clean
build:
	go build -o adm .
vet:
	go vet ./...
test:
	go test ./...
lint: vet
	@for f in comandos_src/*.sh comandos_src/lib/*.sh *.sh; do bash -n "$$f" || exit 1; done
	@if command -v shellcheck >/dev/null; then shellcheck -x -S warning comandos_src/*.sh comandos_src/lib/*.sh; else echo "shellcheck no instalado: solo se comprobó la sintaxis"; fi
install:
	./instalar_comandos.sh
clean:
	rm -f adm
