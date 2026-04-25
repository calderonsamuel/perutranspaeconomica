# Elegir la institucion que utiliza el presupuesto

Estas funciones permiten desglosar la busqueda haciendo uso del
clasificador institucional. `elegir_quien_gasta()` y
`elegir_quien_recauda()` sirven los módulos de gasto e ingresos,
respectivamente. `elegir_institucion()` es una versión agnóstica que
sirve para ámbos módulos.

## Usage

``` r
elegir_institucion(
  x,
  nivel = NULL,
  sector = NULL,
  pliego = NULL,
  unidad_ejecutora = NULL,
  goblocal_o_manc = NULL,
  mancomunidad = NULL,
  departamento = NULL,
  provincia = NULL,
  municipalidad = NULL
)

elegir_quien_gasta(
  x,
  nivel = NULL,
  sector = NULL,
  pliego = NULL,
  unidad_ejecutora = NULL,
  goblocal_o_manc = NULL,
  mancomunidad = NULL,
  departamento = NULL,
  provincia = NULL,
  municipalidad = NULL
)

elegir_quien_recauda(
  x,
  nivel = NULL,
  sector = NULL,
  pliego = NULL,
  unidad_ejecutora = NULL,
  goblocal_o_manc = NULL,
  mancomunidad = NULL,
  departamento = NULL,
  provincia = NULL,
  municipalidad = NULL
)
```

## Arguments

- x:

  Objeto de clase `<transpaeco>` recipiente de los parámetros de la
  consulta deseada

- nivel:

  chr. Nivel de gobierno. Puede ser "E" (gobierno nacional), "M"
  (gobiernos locales) o "R" (gobiernos regionales). Si es "E" o "R", le
  corresponde `sector`. Si es "M", le corresponde `goblocal_o_manc`.

- sector:

  chr. Codigo de sector, de forma "00" (2 digitos).

- pliego:

  chr. Código de pliego, de forma "000" (3 digitos).

- unidad_ejecutora:

  chr. Código de Unidad Ejecutora. No tiene forma estandar, puede tener
  entre uno (1) y seis (6) digitos.

- goblocal_o_manc:

  chr. Escoger entre "M" (gobierno local) o "N" (mancomunidad). Si es
  "M", puede desglosarse por `departamento`, `provincia` y
  `municipalidad`. Si es "N", le corresponde `mancomunidad`.

- mancomunidad:

  chr. Código de mancomunidad, de forma "000000" (6 digitos).

- departamento:

  chr. Código de departamento, de forma "00" (2 digitos). El valor "07"
  corresponde a Callao.

- provincia:

  chr. Código de provincia, de forma "00" (2 digitos). El valor "01"
  corresponde a capital de departamento.

- municipalidad:

  chr. Código de municipalidad, de forma "000000" (6 digitos). **No es
  lo mismo que el ubigeo**. Los dos primeros digitos deben ser "30".

## Value

Un objeto con clase `<transpaeco>`

## Details

Estas funciones aplicarán una validación de la forma para cada argumento
mediante expresiones regulares. Sumado a ello, se aplica una validación
para evitar valores anómalos.

## Examples

``` r
iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_quien_gasta(nivel = "todos")
#> 
#> ── Seguimiento al gasto presupuestal (actualizacion diaria) ────────────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual: 2022
#> • Nivel de gobierno: *todos*
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta

# informacion de todas las UEs del Ministerio de Educacion
iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_quien_gasta(
        nivel = "E", 
        sector = "10",
        pliego = "010",
        unidad_ejecutora = "todos"
    ) %>%
    consultar()
#> ℹ Iniciando consulta
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> # A tibble: 22 × 15
#>    periodo cod_unidad_ejecutora desc_unidad_ejecutora                 pia    pim
#>      <dbl> <chr>                <chr>                               <dbl>  <dbl>
#>  1    2022 001-56               USE 01 SAN JUAN DE MIRAFLORES      5.17e8 5.65e8
#>  2    2022 002-57               USE 02 SAN MARTIN DE PORRAS        4.44e8 4.82e8
#>  3    2022 003-58               USE 03 CERCADO                     3.98e8 4.58e8
#>  4    2022 004-59               USE 04 COMAS                       4.05e8 4.38e8
#>  5    2022 005-60               USE 05 SAN JUAN DE LURIGANCHO      3.81e8 4.05e8
#>  6    2022 006-61               USE 06 VITARTE                     3.61e8 4.10e8
#>  7    2022 007-62               USE 07 SAN BORJA                   2.93e8 3.22e8
#>  8    2022 017-72               DIRECCION DE EDUCACION DE LIMA     1.02e8 1.12e8
#>  9    2022 021-76               ESCUELA NACIONAL DE BELLAS ARTES   9.84e6 1.17e7
#> 10    2022 022-77               INSTITUTO PEDAGOGICO NACIONAL DE … 9.94e6 1.18e7
#> # ℹ 12 more rows
#> # ℹ 10 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, nivel <chr>, sector <chr>, pliego <chr>,
#> #   unidad_ejecutora <chr>

# informacion de todas las provincias de Amazonas.
# notese que devuelve codigos de provincia de 4 digitos.
iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_quien_gasta(
        nivel = "M", 
        goblocal_o_manc = "M",
        departamento = "01",
        provincia = "todos"
    ) %>%
    consultar()
#> ℹ Iniciando consulta
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> # A tibble: 7 × 15
#>   periodo cod_provincia desc_provincia            pia       pim certificacion
#>     <dbl> <chr>         <chr>                   <dbl>     <dbl>         <dbl>
#> 1    2022 0101          CHACHAPOYAS          54050715 137317657     130816267
#> 2    2022 0102          BAGUA                51941023  98204124      94923016
#> 3    2022 0103          BONGARA              25312167  82653885      78830517
#> 4    2022 0104          CONDORCANQUI         37364107  75840175      66238904
#> 5    2022 0105          LUYA                 28410987 105282193      99776567
#> 6    2022 0106          RODRIGUEZ DE MENDOZA 16859438  51198484      48414075
#> 7    2022 0107          UCTUBAMBA            64551770 159578555     142925475
#> # ℹ 9 more variables: compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, nivel <chr>, goblocal_o_manc <chr>,
#> #   departamento <chr>, provincia <chr>

# para desglosar por provincia, deben usarse solo dos digitos.
# por ejemplo, para ver los municipios de la provincia de Bagua
# debe usarse "02"
iniciar_transparencia_economica(modulo = "gasto") %>%
    elegir_periodo_anual(2022) %>%
    elegir_quien_gasta(
        nivel = "M", 
        goblocal_o_manc = "M",
        departamento = "01",
        provincia = "02",
        municipalidad = "todos"
    ) %>%
    consultar()
#> ℹ Iniciando consulta
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> # A tibble: 6 × 16
#>   periodo cod_municipalidad desc_municipalidad          pia    pim certificacion
#>     <dbl> <chr>             <chr>                     <dbl>  <dbl>         <dbl>
#> 1    2022 010201-300022     MUNICIPALIDAD PROVINCIA… 1.51e7 2.82e7      27143174
#> 2    2022 010202-300023     MUNICIPALIDAD DISTRITAL… 2.19e7 3.47e7      34505079
#> 3    2022 010203-300024     MUNICIPALIDAD DISTRITAL… 1.94e6 3.39e6       3352729
#> 4    2022 010204-300025     MUNICIPALIDAD DISTRITAL… 6.64e5 3.49e6       3474440
#> 5    2022 010205-300026     MUNICIPALIDAD DISTRITAL… 1.01e7 1.71e7      16284737
#> 6    2022 010206-300027     MUNICIPALIDAD DISTRITAL… 2.25e6 1.12e7      10162857
#> # ℹ 10 more variables: compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, nivel <chr>, goblocal_o_manc <chr>,
#> #   departamento <chr>, provincia <chr>, municipalidad <chr>

# cuando no se respeta la forma, el mensaje de error
# muestra la expresion regular esperada
tryCatch({
    iniciar_transparencia_economica(modulo = "gasto") %>%
        elegir_periodo_anual(2022) %>%
        elegir_quien_gasta(
            nivel = "M", 
            goblocal_o_manc = "M",
            departamento = "01",
            provincia = "0102",
            municipalidad = "todos"
        )
}, error = function(e) print(e))
#> <simpleError: <perutranspaeconomica::transpaeco> object is invalid:
#> - En modulo gasto, `provincia` debe hacer match con expresion regular '^[0-9]{2}$'>
```
