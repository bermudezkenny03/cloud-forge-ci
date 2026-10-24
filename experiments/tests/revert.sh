#!/usr/bin/env bash
# Restaura tests: return a + b (no cambiar el expected del test).
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$root"
python3 - <<'PY'
from pathlib import Path
path = Path("app/calculadora.py")
text = path.read_text(encoding="utf-8")
old = "def sumar(a: int, b: int) -> int:\n    return a - b\n"
new = "def sumar(a: int, b: int) -> int:\n    return a + b\n"
if old not in text:
    raise SystemExit("no se encontró la versión rota de sumar")
path.write_text(text.replace(old, new, 1), encoding="utf-8")
print("Revertido: sumar vuelve a sumar")
PY
