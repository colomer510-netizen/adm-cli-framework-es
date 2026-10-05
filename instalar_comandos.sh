#!/bin/bash
set -e
echo "📦 Instalando CLI Maestro 'adm'..."
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if command -v go >/dev/null 2>&1; then
    echo "🔨 Compilando..."
    (cd "$PROJECT_DIR" && go build -o adm .)
elif [ ! -x "$PROJECT_DIR/adm" ]; then
    echo "❌ No hay binario 'adm' ni Go instalado (sudo apt install golang)." >&2
    exit 1
fi

mkdir -p ~/.local/bin
ln -sf "$PROJECT_DIR/adm" ~/.local/bin/adm
chmod +x "$PROJECT_DIR/adm"

# Autocompletado para bash
COMP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions"
mkdir -p "$COMP_DIR"
"$PROJECT_DIR/adm" completion bash > "$COMP_DIR/adm" 2>/dev/null && echo "⌨️  Autocompletado instalado en $COMP_DIR/adm"

case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) echo "⚠️  ~/.local/bin no está en tu PATH. Añade a ~/.bashrc: export PATH=\"\$HOME/.local/bin:\$PATH\"" ;;
esac

echo "✅ Instalación completada. Escribe 'adm' para comenzar (abre una terminal nueva para el autocompletado)."
