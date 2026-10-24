#!/usr/bin/env bash
# Experimento 4 — secrets: token sintético CFDEMO_ (sin acceso real).
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$root"
printf 'DEMO_TOKEN=CFDEMO_ABCDEFGHIJKLMNOPQRSTUVWX\n' > app/demo.env
echo "Aplicado: app/demo.env con token sintético de laboratorio"
