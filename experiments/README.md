# Experimentos de fallo (Laboratorio 2)

Cada experimento es **independiente**: partí siempre de la línea base verde, aplicá un solo fallo, verificá que `package` no corre (o falla por `needs: checks`), registrá evidencia y restaurá con el fix indicado. No combines demos.

| # | Control | Cómo provocar el fallo | Restauración |
|---|---------|------------------------|--------------|
| 1 | lint | `bash experiments/lint/apply.sh` → F401 por `import os` sin usar | `bash experiments/lint/revert.sh` (eliminar import; no `# noqa`) |
| 2 | tests | `bash experiments/tests/apply.sh` → `sumar` resta | `bash experiments/tests/revert.sh` (restaurar `a + b`; no cambiar el expected) |
| 3 | sast | `bash experiments/sast/apply.sh` → Bandit B307 (`eval`) | `bash experiments/sast/revert.sh` (eliminar función; no `# nosec`) |
| 4 | secrets | `bash experiments/secrets/apply.sh` → `app/demo.env` con token sintético | `bash experiments/secrets/revert.sh` (borrar `demo.env`) |
| 5 | sca | `bash experiments/sca/apply.sh` → `requests==2.19.1` en `requirements.txt` | `bash experiments/sca/revert.sh` (quitar dependencia; no instalarla) |

Flujo sugerido por experimento:

```bash
# 1. Línea base limpia
git status   # working tree clean

# 2. Aplicar solo este control
bash experiments/<control>/apply.sh
git add -A && git commit -m "lab2: fallo <control>"
git push

# 3. En Actions: el job <control> rojo; package no publica ZIP

# 4. Corregir
bash experiments/<control>/revert.sh
git add -A && git commit -m "lab2: fix <control>"
git push
```

Plantilla de evidencias: [`matriz-evidencias.csv`](matriz-evidencias.csv).

**Seguridad:** el token `CFDEMO_…` es sintético y no da acceso a ningún servicio. No uses credenciales reales.
