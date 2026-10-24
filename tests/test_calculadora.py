"""Pruebas unitarias de la calculadora."""

import pytest

from app.calculadora import interpretar_entero, sumar


def test_suma() -> None:
    assert sumar(2, 3) == 5


def test_entero() -> None:
    assert interpretar_entero("42") == 42


def test_rechaza_expresiones() -> None:
    with pytest.raises(ValueError):
        interpretar_entero("2 + 3")
