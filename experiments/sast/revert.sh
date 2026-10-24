#!/usr/bin/env bash
# Restaura SAST eliminando la función insegura (sin nosec).
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$root"
python3 - <<'PY'
from pathlib import Path
path = Path("app/calculadora.py")
text = path.read_text(encoding="utf-8")
marker = "\n\ndef ejemplo_inseguro():\n    return eval(\"2 + 3\")\n"
if marker not in text:
    # tolerar variante sin newline final doble
    marker = "\ndef ejemplo_inseguro():\n    return eval(\"2 + 3\")\n"
if "def ejemplo_inseguro" not in text:
    raise SystemExit("ejemplo_inseguro no está presente")
# Eliminar desde la definición hasta EOF de esa función
lines = text.splitlines(keepends=True)
out: list[str] = []
skip = False
for ln in lines:
    if ln.startswith("def ejemplo_inseguro"):
        skip = True
        continue
    if skip:
        if ln.startswith("def ") or (ln.strip() and not ln.startswith(" ") and not ln.startswith("\t")):
            skip = False
            out.append(ln)
        continue
    out.append(ln)
path.write_text("".join(out).rstrip() + "\n", encoding="utf-8")
print("Revertido: eliminada ejemplo_inseguro")
PY
