# Elegir lugar de uso del presupuesto

Estas funciones permiten desglosar la busqueda de acuerdo al lugar de
uso del presupuesto. Debido a que solo se pueden usar en el módulo de
gasto, ambas tienen el mismo comportamiento.

## Usage

``` r
elegir_lugar(x, departamento_meta = NULL)

elegir_donde_se_gasta(x, departamento_meta = NULL)
```

## Arguments

- x:

  Objeto de clase `<transpaeco>` recipiente de los parámetros de la
  consulta deseada

- departamento_meta:

  chr. Código de departamento, de forma "00" (2 digitos). Para obtener
  "Callao" usar "07", y para obtener 'Exterior' usar "98".

## Value

Un objeto con clase `<transpaeco>`

## Examples

``` r
iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_donde_se_gasta(
        departamento_meta = "todos"
    )
#> 
#> ── Seguimiento al gasto presupuestal (actualizacion diaria) ────────────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual: 2022
#> • Departamento (meta): *todos*
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta

iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_donde_se_gasta(
        departamento_meta = "todos"
    ) %>%
    consultar()
#> ℹ Iniciando consulta
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> # A tibble: 26 × 12
#>    periodo cod_departamento_meta desc_departamento_meta              pia     pim
#>      <dbl> <chr>                 <chr>                             <dbl>   <dbl>
#>  1    2022 01                    AMAZONAS                         2.26e9 3.06e 9
#>  2    2022 02                    ANCASH                           6.59e9 1.11e10
#>  3    2022 03                    APURIMAC                         2.43e9 4.06e 9
#>  4    2022 04                    AREQUIPA                         5.70e9 8.97e 9
#>  5    2022 05                    AYACUCHO                         3.13e9 5.14e 9
#>  6    2022 06                    CAJAMARCA                        5.41e9 8.64e 9
#>  7    2022 07                    PROVINCIA CONSTITUCIONAL DEL CA… 4.64e9 5.85e 9
#>  8    2022 08                    CUSCO                            7.55e9 1.21e10
#>  9    2022 09                    HUANCAVELICA                     2.41e9 3.36e 9
#> 10    2022 10                    HUANUCO                          3.49e9 4.66e 9
#> # ℹ 16 more rows
#> # ℹ 7 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, departamento_meta <chr>

# cuando no se respeta la forma, el mensaje de error
# muestra la expresion regular esperada
tryCatch({
    iniciar_transparencia_economica(modulo = "gasto") %>%
        elegir_periodo_anual(2022) %>%
        elegir_donde_se_gasta(
            departamento_meta = "2-0"
        )
}, error = function(e) print(e))
#> <simpleError: <perutranspaeconomica::transpaeco> object is invalid:
#> - En modulo gasto, `departamento_meta` debe hacer match con expresion regular '^[0-9]{2}'>
```
