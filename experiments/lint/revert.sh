#!/usr/bin/env bash
# Restaura lint eliminando el import (sin noqa).
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$root"
python3 - <<'PY'
from pathlib import Path
path = Path("app/calculadora.py")
lines = path.read_text(encoding="utf-8").splitlines(keepends=True)
filtered = [ln for ln in lines if ln.strip() != "import os"]
# Quitar línea en blanco extra dejada tras el docstring si quedó doble blank.
out: list[str] = []
blank_run = 0
for ln in filtered:
    if ln.strip() == "":
        blank_run += 1
        if blank_run > 1:
            continue
    else:
        blank_run = 0
    out.append(ln)
path.write_text("".join(out), encoding="utf-8")
print("Revertido: eliminado import os")
PY
