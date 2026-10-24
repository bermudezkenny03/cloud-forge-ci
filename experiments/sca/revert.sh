#!/usr/bin/env bash
# Restaura SCA dejando el comentario inicial (sin requests).
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$root"
cat > requirements.txt <<'EOF'
# Sin dependencias de runtime: la aplicación usa la biblioteca estándar.
EOF
echo "Revertido: requirements.txt sin dependencia vulnerable"
