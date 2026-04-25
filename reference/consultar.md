# Ejecutar consulta de seguimiento a la ejecución presupuestal

Ejecutar consulta de seguimiento a la ejecución presupuestal

## Usage

``` r
consultar(x)
```

## Arguments

- x:

  Objeto de clase `<transpaeco>` recipiente de los parámetros de la
  consulta deseada

## Value

Un data.frame que contiene el resultado de la consulta solicitada

## Examples

``` r
iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    consultar()
#> ℹ Iniciando consulta
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> # A tibble: 1 × 10
#>   periodo total          pia          pim certificacion compromiso_anual
#>     <dbl> <chr>        <dbl>        <dbl>         <dbl>            <dbl>
#> 1    2022 TOTAL 197002269014 238070181438  225523178395     215880903410
#> # ℹ 4 more variables: atencion_de_compromiso_mensual <dbl>, devengado <dbl>,
#> #   girado <dbl>, avance_percent <dbl>
```
