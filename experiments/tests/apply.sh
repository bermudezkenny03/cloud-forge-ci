#!/usr/bin/env bash
# Experimento 2 — tests: sumar resta en lugar de sumar.
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$root"
python3 - <<'PY'
from pathlib import Path
path = Path("app/calculadora.py")
text = path.read_text(encoding="utf-8")
old = "def sumar(a: int, b: int) -> int:\n    return a + b\n"
new = "def sumar(a: int, b: int) -> int:\n    return a - b\n"
if old not in text:
    raise SystemExit("no se encontró la implementación esperada de sumar")
path.write_text(text.replace(old, new, 1), encoding="utf-8")
print("Aplicado: sumar ahora resta (rompe test_suma)")
PY
