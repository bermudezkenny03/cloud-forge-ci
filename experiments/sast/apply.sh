#!/usr/bin/env bash
# Experimento 3 — SAST: eval() dispara Bandit B307.
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$root"
python3 - <<'PY'
from pathlib import Path
path = Path("app/calculadora.py")
text = path.read_text(encoding="utf-8")
if "def ejemplo_inseguro" in text:
    raise SystemExit("ejemplo_inseguro ya presente; abortando")
snippet = '''

def ejemplo_inseguro():
    return eval("2 + 3")
'''
path.write_text(text.rstrip() + snippet, encoding="utf-8")
print("Aplicado: ejemplo_inseguro con eval (B307)")
PY
