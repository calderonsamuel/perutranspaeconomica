# Elegir destino de uso del presupuesto.

Estas funciones permiten desglosar la busqueda de acuerdo al destino de
uso del presupuesto. Debido a que solo se pueden usar en el módulo de
gasto, ambas tienen el mismo comportamiento.

## Usage

``` r
elegir_destino(
  x,
  categoria_presupuestal = NULL,
  producto = NULL,
  actividad = NULL,
  funcion = NULL,
  division_funcional = NULL,
  grupo_funcional = NULL,
  meta = NULL
)

elegir_en_que_se_gasta(
  x,
  categoria_presupuestal = NULL,
  producto = NULL,
  actividad = NULL,
  funcion = NULL,
  division_funcional = NULL,
  grupo_funcional = NULL,
  meta = NULL
)
```

## Arguments

- x:

  Objeto de clase `<transpaeco>` recipiente de los parámetros de la
  consulta deseada

- categoria_presupuestal:

  chr. Código de programa presupuestal de forma "0000" (4 digitos). Para
  Acciones Centrales usar "9001" y para APnoP usar "9002".

- producto:

  chr. Código de producto o proyecto de inversión de forma "0000000" (7
  digitos).

- actividad:

  chr. Código de actividad, acción de inversión u obra, de forma
  "0000000" (7 digitos).

- funcion:

  chr. Código de función de forma "00" (2 digitos).

- division_funcional:

  chr. Código de división funcional de forma "000" (3 digitos).

- grupo_funcional:

  chr. Código de grupo funcional de forma "0000" (4 digitos).

- meta:

  chr. Código de meta. No tiene forma estandarizada y no es obtenerla a
  partir de la información provista. Es el parametro de consulta mas
  problematico.

## Value

Un objeto con clase `<transpaeco>`

## Examples

``` r
iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_en_que_se_gasta(categoria_presupuestal = "todos")
#> 
#> ── Seguimiento al gasto presupuestal (actualizacion diaria) ────────────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual: 2022
#> • Categoria Presupuestal: *todos*
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta

iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_en_que_se_gasta(categoria_presupuestal = "todos") %>%
    consultar()
#> ℹ Iniciando consulta
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> # A tibble: 92 × 12
#>    periodo cod_categoria_presupuestal desc_categoria_presupuestal     pia    pim
#>      <dbl> <chr>                      <chr>                         <dbl>  <dbl>
#>  1    2022 0001                       PROGRAMA ARTICULADO NUTRICI… 8.88e8 1.29e9
#>  2    2022 0002                       SALUD MATERNO NEONATAL       2.12e9 2.52e9
#>  3    2022 0016                       TBC-VIH/SIDA                 6.05e8 7.02e8
#>  4    2022 0017                       ENFERMEDADES METAXENICAS Y … 3.14e8 3.53e8
#>  5    2022 0018                       ENFERMEDADES NO TRANSMISIBL… 5.69e8 6.96e8
#>  6    2022 0024                       PREVENCION Y CONTROL DEL CA… 4.61e8 8.12e8
#>  7    2022 0030                       REDUCCION DE DELITOS Y FALT… 4.48e9 5.21e9
#>  8    2022 0031                       REDUCCION DEL TRAFICO ILICI… 2.68e8 2.74e8
#>  9    2022 0032                       LUCHA CONTRA EL TERRORISMO   2.30e8 2.40e8
#> 10    2022 0036                       GESTION INTEGRAL DE RESIDUO… 1.61e9 2.69e9
#> # ℹ 82 more rows
#> # ℹ 7 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, categoria_presupuestal <chr>
```
