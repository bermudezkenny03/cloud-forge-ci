#!/usr/bin/env bash
# Restaura secrets eliminando demo.env.
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$root"
rm -f app/demo.env
echo "Revertido: eliminado app/demo.env"
