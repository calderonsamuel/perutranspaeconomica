# Elegir la estructura con la que se usa el presupuesto

Estas funciones permiten desglosar la busqueda de acuerdo a valores de
estructura presupuestal. `elegir_como_se_estructura_gasto()` y
`elegir_como_se_estructura_recaudacion()` sirven para los módulos de
gasto e ingresos, respectivamente. `elegir_estructura()` es una versión
agnóstica que sirve para ámbos módulos. Ver Detalles para entender la
conformacion del formato de consulta de cada parametro.

## Usage

``` r
elegir_estructura(
  x,
  generica = NULL,
  subgenerica = NULL,
  detalle_subgenerica = NULL,
  especifica = NULL,
  detalle_especifica = NULL
)

elegir_como_se_estructura_gasto(
  x,
  generica = NULL,
  subgenerica = NULL,
  detalle_subgenerica = NULL,
  especifica = NULL,
  detalle_especifica = NULL
)

elegir_como_se_estructura_recaudacion(
  x,
  generica = NULL,
  subgenerica = NULL,
  detalle_subgenerica = NULL,
  especifica = NULL,
  detalle_especifica = NULL
)
```

## Arguments

- x:

  Objeto de clase `<transpaeco>` recipiente de los parámetros de la
  consulta deseada

- generica:

  chr. Código de genérica. En módulo de *gasto* debe tener la forma
  "0-0-0" y en módulo de *ingreso* debe tener la forma "0-0".

- subgenerica:

  chr. Código de sub-genérica de forma "0-0-0"

- detalle_subgenerica:

  chr. Código de detalle de sub-genérica de forma "0-0-0-0"

- especifica:

  chr. Código de específica de forma "0-0-0-0-0"

- detalle_especifica:

  chr. Código de detalle de específica de forma "0-0-0-0-0-0"

## Value

Un objeto con clase `<transpaeco>`

## Details

Estos endpoints se construyen secuencialmente en base a los valores de
genérica.

Para escribir el código de genérica se debe alterar un poco la
representación típica. Por ejemplo, la genérica de *gasto* "7-28" debe
pasarse a `generica` como "7-2-8".

A partir del nivel `subgenerica` debe omitirse solo el primer dígito de
la genérica. Por ejemplo, la sub-genérica "7-28.2" debe pasarse como
"2-8-2" y para el detalle de la sub-genérica "7-28.2.1" debe pasarse
"2-8-2-1". La específica y detalle de específica siguen este patrón.

Estas funciones aplicarán una validación de la forma para cada argumento
mediante expresiones regulares. Sumado a ello, se aplica una validación
para evitar valores anómalos.

## Examples

``` r
iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_como_se_estructura_gasto(generica = "todos") 
#> 
#> ── Seguimiento al gasto presupuestal (actualizacion diaria) ────────────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual: 2022
#> • Generica: *todos*
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta

iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_como_se_estructura_gasto(generica = "todos") %>%
    consultar()
#> ℹ Iniciando consulta
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> # A tibble: 12 × 12
#>    periodo cod_generica desc_generica                  pia     pim certificacion
#>      <dbl> <chr>        <chr>                        <dbl>   <dbl>         <dbl>
#>  1    2022 5-20         RESERVA DE CONTINGENCIA    6.17e 9 1.20e 9             0
#>  2    2022 5-21         PERSONAL Y OBLIGACIONES S… 5.18e10 5.42e10   53418751208
#>  3    2022 5-22         PENSIONES Y OTRAS PRESTAC… 1.36e10 1.40e10   13934008724
#>  4    2022 5-23         BIENES Y SERVICIOS         4.05e10 5.34e10   49986139568
#>  5    2022 5-24         DONACIONES Y TRANSFERENCI… 7.16e 9 6.40e 9    6215948303
#>  6    2022 5-25         OTROS GASTOS               6.85e 9 1.50e10   14953034768
#>  7    2022 6-20         RESERVA DE CONTINGENCIA    2   e 8 0                   0
#>  8    2022 6-24         DONACIONES Y TRANSFERENCI… 4.21e 9 3.96e 9    3892715114
#>  9    2022 6-25         OTROS GASTOS               5.64e 7 1.29e 8     128215011
#> 10    2022 6-26         ADQUISICION DE ACTIVOS NO… 4.31e10 6.63e10   60534497990
#> 11    2022 6-27         ADQUISICION DE ACTIVOS FI… 3.65e 8 4.17e 8     405825864
#> 12    2022 7-28         SERVICIO DE LA DEUDA PUBL… 2.30e10 2.31e10   22054041846
#> # ℹ 6 more variables: compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, generica <chr>

# notese la forma de `generica`
iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_como_se_estructura_gasto(
        generica = "5-2-0", 
        subgenerica = "todos"
    ) 
#> 
#> ── Seguimiento al gasto presupuestal (actualizacion diaria) ────────────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual: 2022
#> • Generica: 5-2-0
#> • Sub-generica: *todos*
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta

# cuando no se respeta la forma, el mensaje de error 
# muestra la expresion regular esperada
tryCatch({
    iniciar_transparencia_economica(modulo = "gasto") %>%
        elegir_periodo_anual(2022) %>%
        elegir_como_se_estructura_gasto(
            generica = "5-20", 
            subgenerica = "todos"
        ) 
}, error = function(e) print(e))
#> <simpleError: <perutranspaeconomica::transpaeco> object is invalid:
#> - En modulo gasto, `generica` debe hacer match con expresion regular '^[5-7]-2-[0-9]$'>
```
