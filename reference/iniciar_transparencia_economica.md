# Iniciar consulta de transparencia economica

Iniciar consulta de transparencia economica

## Usage

``` r
iniciar_transparencia_economica(
  modulo = "gasto",
  actualizacion = "diaria",
  psize = 1000L
)
```

## Arguments

- modulo:

  chr. Uno de c("gasto", "ingreso")

- actualizacion:

  chr. Uno de c("mensual", "diaria")

- psize:

  Cantidad máxima de filas del resultado. No cambiar a menos que se sepa
  con mucha seguridad lo que implica.

## Value

Un objeto con clase `<transpaeco>`

## Examples

``` r
iniciar_transparencia_economica(modulo = "gasto")
#> 
#> ── Seguimiento al gasto presupuestal (actualizacion diaria) ────────────────────
#> 
#> ── Parametros de consulta ──
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta
iniciar_transparencia_economica(modulo = "gasto", actualizacion = "diaria")
#> 
#> ── Seguimiento al gasto presupuestal (actualizacion diaria) ────────────────────
#> 
#> ── Parametros de consulta ──
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta
iniciar_transparencia_economica(modulo = "ingreso")
#> 
#> ── Seguimiento al ingreso presupuestal (actualizacion diaria) ──────────────────
#> 
#> ── Parametros de consulta ──
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta
```
