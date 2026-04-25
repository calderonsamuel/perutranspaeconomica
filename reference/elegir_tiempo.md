# Elegir el tiempo en que se usa el presupuesto

Estas funciones permiten desglosar la busqueda de acuerdo al tiempo en
el periodo anual. `elegir_cuando_se_hizo_gasto()` y
`elegir_cuando_se_hizo_recaudacion()` sirven los módulos de gasto e
ingresos, respectivamente. `elegir_tiempo()` es una versión agnóstica
que sirve para ámbos módulos. Al desglosar por mes o trimestre se pierde
información de PIA, PIM y porcentaje de avance (en *gasto*).

## Usage

``` r
elegir_tiempo(x, trimestre = NULL, mes = NULL)

elegir_cuando_se_hizo_gasto(x, trimestre = NULL, mes = NULL)

elegir_cuando_se_hizo_recaudacion(x, trimestre = NULL, mes = NULL)
```

## Arguments

- x:

  Objeto de clase `<transpaeco>` recipiente de los parámetros de la
  consulta deseada

- trimestre:

  int. Número del 1 al 4

- mes:

  int. Número del 1 al 12.

## Value

Un objeto con clase `<transpaeco>`

## Examples

``` r
iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_cuando_se_hizo_gasto(mes = "todos")
#> 
#> ── Seguimiento al gasto presupuestal (actualizacion diaria) ────────────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual: 2022
#> • Mes: *todos*
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta

iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_cuando_se_hizo_gasto(mes = "todos") %>%
    consultar()
#> ℹ Iniciando consulta
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> # A tibble: 12 × 12
#>    periodo cod_mes desc_mes     pia   pim certificacion compromiso_anual
#>      <dbl> <chr>   <chr>      <dbl> <dbl>         <dbl>            <dbl>
#>  1    2022 1       'Enero        NA    NA  103760176942      83786700445
#>  2    2022 2       'Febrero      NA    NA   22122399984      14571055897
#>  3    2022 3       'Marzo        NA    NA   18770905498      15052437795
#>  4    2022 4       'Abril        NA    NA   11024517329      11173480674
#>  5    2022 5       'Mayo         NA    NA    9440914773       9724750158
#>  6    2022 6       'Junio        NA    NA    8241901905       9607163097
#>  7    2022 7       'Julio        NA    NA    7639402271       9590125437
#>  8    2022 8       'Agosto       NA    NA   12105649334      12597151772
#>  9    2022 9       'Setiembre    NA    NA    7118790229       9769213214
#> 10    2022 10      'Octubre      NA    NA    7674671123      10753134066
#> 11    2022 11      'Noviembre    NA    NA    6314807756      10162306626
#> 12    2022 12      'Diciembre    NA    NA   11309041251      19093384230
#> # ℹ 5 more variables: atencion_de_compromiso_mensual <dbl>, devengado <dbl>,
#> #   girado <dbl>, avance_percent <dbl>, mes <chr>

# se emite mensaje de error si se intenta elegir periodos no abarcados
tryCatch({
    iniciar_transparencia_economica(modulo = "gasto") %>%
        elegir_periodo_anual(periodo = 2022) %>%
        elegir_cuando_se_hizo_gasto(trimestre = "5")
        
}, error = function(e) print(e))
#> <simpleError: <perutranspaeconomica::transpaeco> object is invalid:
#> - (En modulo gasto, `trimestre` debe ser uno de 1, 2, 3, 4)>
```
