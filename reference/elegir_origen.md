# Elegir el origen del presupuesto

Estas funciones permiten desglosar la busqueda de acuerdo al origen del
financiamiento del presupuesto. `elegir_con_que_se_financia()` y
`elegir_fuentes_de_recaudacion()` sirven los módulos de gasto e
ingresos, respectivamente. `elegir_origen()` es una versión agnóstica
que sirve para ámbos módulos.

## Usage

``` r
elegir_origen(
  x,
  fuente_financiamiento = NULL,
  rubro = NULL,
  tipo_de_recurso = NULL
)

elegir_con_que_se_financia(
  x,
  fuente_financiamiento = NULL,
  rubro = NULL,
  tipo_de_recurso = NULL
)

elegir_fuentes_de_recaudacion(
  x,
  fuente_financiamiento = NULL,
  rubro = NULL,
  tipo_de_recurso = NULL
)
```

## Arguments

- x:

  Objeto de clase `<transpaeco>` recipiente de los parámetros de la
  consulta deseada

- fuente_financiamiento:

  int. Código de fuente de financiamiento. En su versión más reciente va
  del 1 al 5.

- rubro:

  chr. código de rubro, de forma "00" (2 digitos).

- tipo_de_recurso:

  chr, Código de tipo de recurso. No tiene forma estandar, puede ser de
  una letra mayuscula, un digito, o dos digitos.

## Value

Un objeto con clase `<transpaeco>`

## Examples

``` r
iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_con_que_se_financia(
        rubro = "todos"
    )
#> 
#> ── Seguimiento al gasto presupuestal (actualizacion diaria) ────────────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual: 2022
#> • Rubro: *todos*
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta

iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_con_que_se_financia(
        rubro = "todos"
    ) %>%
    consultar()
#> ℹ Iniciando consulta
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> # A tibble: 8 × 12
#>   periodo cod_rubro desc_rubro        pia     pim certificacion compromiso_anual
#>     <dbl> <chr>     <chr>           <dbl>   <dbl>         <dbl>            <dbl>
#> 1    2022 00        RECURSOS ORD… 1.19e11 1.26e11  122337990513     120687753935
#> 2    2022 04        CONTRIBUCION… 4.93e 9 5.05e 9    5047115254       5029616816
#> 3    2022 07        FONDO DE COM… 6.79e 9 1.04e10    9765688281       9281123706
#> 4    2022 08        IMPUESTOS MU… 3.19e 9 4.28e 9    4012570866       3763048346
#> 5    2022 09        RECURSOS DIR… 1.21e10 1.65e10   15309498719      14769006206
#> 6    2022 13        DONACIONES Y… 2.30e 8 6.07e 9    5099003630       4471433562
#> 7    2022 18        CANON Y SOBR… 1.29e10 3.07e10   27501686979      22620644131
#> 8    2022 19        RECURSOS POR… 3.81e10 3.90e10   36449624152      35258276709
#> # ℹ 5 more variables: atencion_de_compromiso_mensual <dbl>, devengado <dbl>,
#> #   girado <dbl>, avance_percent <dbl>, rubro <chr>

# desglose de tipo de recurso del rubro de "13: Donaciones y transferencias"
# notese la variacion en los codigos de tipo de recurso
iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_con_que_se_financia(
        rubro = "13",
        tipo_de_recurso = "todos"
    ) %>%
    consultar()
#> ℹ Iniciando consulta
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> # A tibble: 22 × 13
#>    periodo cod_tipo_de_recurso desc_tipo_de_recurso     pia    pim certificacion
#>      <dbl> <chr>               <chr>                  <dbl>  <dbl>         <dbl>
#>  1    2022 A                   TRANSFERENCIAS DE EN… 0      0                  0
#>  2    2022 B                   TRANSFERENCIAS DE EN… 0      0                  0
#>  3    2022 C                   TRANSFERENCIA DE GOB… 0      0                  0
#>  4    2022 E                   TRANSFERENCIAS DE CA… 0      0                  0
#>  5    2022 N                   DONACIONES PARA APOY… 0      0                  0
#>  6    2022 O                   SUBCUENTA- TRANSFERE… 0      0                  0
#>  7    2022 P                   SUBCUENTA- TRANSFERE… 0      0                  0
#>  8    2022 0                   NORMAL                2.30e8 6.07e9    5099003630
#>  9    2022 10                  DONACIONES - AGENCIA… 0      0                  0
#> 10    2022 12                  DONACIONES -VIAJA BN  0      0                  0
#> # ℹ 12 more rows
#> # ℹ 7 more variables: compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, rubro <chr>, tipo_de_recurso <chr>

# cuando no se respeta la forma, el mensaje de error
# muestra la expresion regular esperada
tryCatch({
    iniciar_transparencia_economica(modulo = "gasto") %>%
        elegir_periodo_anual(2022) %>%
        elegir_con_que_se_financia(
            rubro = "13",
            tipo_de_recurso = "AA"
        )
}, error = function(e) print(e))
#> <simpleError: <perutranspaeconomica::transpaeco> object is invalid:
#> - En modulo gasto, `tipo_de_recurso` debe hacer match con expresion regular '(^[A-Z]$)|(^[0-9]{1,2}$)'>
```
