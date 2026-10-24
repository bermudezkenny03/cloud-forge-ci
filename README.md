# cloud-forge-ci — Laboratorio 2 · Pipeline seguro

Material del **Diplomado Cloud Forge** (Módulo 3 · Sesión 2): CI con Ruff, pytest, Bandit y Trivy; cinco fallos independientes que bloquean el empaquetado.

## Estructura

```
app/                    # Calculadora (sumar + interpretar_entero)
tests/                  # Tres pruebas unitarias
requirements.txt        # Runtime vacío (stdlib)
requirements-dev.txt    # ruff, pytest, bandit (excluido del SCA)
pyproject.toml
security/trivy-secret.yaml
ci/check.sh
.github/workflows/secure-ci.yml
experiments/            # Scripts apply/revert por control + matriz CSV
```

## Requisitos locales

- Python 3.11+
- Docker (solo para controles `secrets` y `sca` con Trivy 0.61.1)

```bash
python3.11 -m venv .venv
source .venv/bin/activate
pip install -r requirements-dev.txt
chmod +x ci/check.sh experiments/*/apply.sh experiments/*/revert.sh
```

## Controles (línea base)

```bash
bash ci/check.sh lint
bash ci/check.sh tests
bash ci/check.sh sast
bash ci/check.sh secrets   # requiere Docker
bash ci/check.sh sca       # requiere Docker
```

En GitHub Actions, el workflow **Secure CI** corre la matriz `lint|tests|sast|secrets|sca` (`fail-fast: false`) y el job **package** solo si todos pasan: genera `dist/cloud-forge.zip` (app + requirements.txt).

## Experimentos de fallo

Ver [`experiments/README.md`](experiments/README.md). Un control por commit; restaurar antes del siguiente. El token `CFDEMO_…` es sintético y no da acceso a servicios.

## Seguridad

- No uses credenciales reales ni datos personales.
- No instales `requests==2.19.1` del experimento SCA; solo sirve para el escaneo.
