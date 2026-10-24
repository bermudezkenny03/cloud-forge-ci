#!/usr/bin/env bash
# Experimento 1 — lint: import sin usar (Ruff F401).
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$root"
python3 - <<'PY'
from pathlib import Path
path = Path("app/calculadora.py")
text = path.read_text(encoding="utf-8")
needle = '"""Calculadora mínima: suma e interpretación segura de enteros."""\n'
insert = needle + "\nimport os\n"
if "import os" in text:
    raise SystemExit("import os ya presente; abortando")
if needle not in text:
    raise SystemExit("no se encontró el docstring esperado en calculadora.py")
path.write_text(text.replace(needle, insert, 1), encoding="utf-8")
print("Aplicado: import os sin usar en app/calculadora.py")
PY
