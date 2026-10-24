#!/usr/bin/env bash
# Experimento 5 — SCA: dependencia obsoleta solo para escaneo (no instalar).
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$root"
cat > requirements.txt <<'EOF'
# Dependencia obsoleta solo para escaneo; no instalar.
requests==2.19.1
EOF
echo "Aplicado: requests==2.19.1 en requirements.txt (no instalar)"
