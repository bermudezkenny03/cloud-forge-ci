#!/usr/bin/env bash
# Experimento 4 — secrets: token sintetico (sin acceso real).
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$root"
prefix=CFDEMO_
suffix=ABCDEFGHIJKLMNOPQRSTUVWX
printf 'DEMO_TOKEN=%s%s\n' "$prefix" "$suffix" > app/demo.env
echo "Aplicado: app/demo.env con token sintetico de laboratorio"
