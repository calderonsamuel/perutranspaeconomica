
<!-- README.md is generated from README.Rmd. Please edit that file -->

# perutranspaeconomica

<!-- badges: start -->

![runiverse-name](https://calderonsamuel.r-universe.dev/badges/:name)
![runiverse-package](https://calderonsamuel.r-universe.dev/badges/perutranspaeconomica)
[![Codecov test
coverage](https://codecov.io/gh/calderonsamuel/perutranspaeconomica/branch/main/graph/badge.svg)](https://app.codecov.io/gh/calderonsamuel/perutranspaeconomica?branch=main)
[![CRAN
status](https://www.r-pkg.org/badges/version/perutranspaeconomica)](https://CRAN.R-project.org/package=perutranspaeconomica)
[![R-CMD-check](https://github.com/calderonsamuel/perutranspaeconomica/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/calderonsamuel/perutranspaeconomica/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
<!-- badges: end -->

El objetivo de `{perutranspaeconomica}` es contar con una manera de
obtener datos del Portal de Transparencia Económica Perú desde R, con
una interfaz de programación consistente y clara.

## Code of Conduct

Please note that the perutranspaeconomica project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Instalación

Puedes instalar el paquete desde mi
[R-universe](https://calderonsamuel.r-universe.dev/):

``` r
# Habilita el repositorio calderonsamuel
options(repos = c(
  calderonsamuel = 'https://calderonsamuel.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))

# Descargar e instalar perutranspaeconomica en R
install.packages('perutranspaeconomica')
```

También puedes instalar la versión en desarrollo de
`{perutranspaeconomica}` desde [GitHub](https://github.com/) con:

``` r
# install.packages("remotes")
remotes::install_github("calderonsamuel/perutranspaeconomica", "devel")
```

## Ejemplo

Con este paquete puedes realizar consultas del Portal de Transparencia
Económica del MEF-Perú, específicamente en el [módulo de gasto de
seguimiento a la ejecución
presupuestal](https://www.mef.gob.pe/es/?option=com_content&language=es-ES&Itemid=100944&lang=es-ES&view=article&id=504).

El paquete propone un flujo de trabajo de 1) iniciar consulta, 2) elegir
parámetros, y 3) ejecutar consulta. Para ello, se ha creado la clase
‘sep_df’ para consolidar una infraestructura interna consistente. EL
usuario común no va a necesitar interactuar con esa infraestructura
directamente ya que se han agregado funciones de soporte que habilitan
una interfaz de programación más amigable.

Empezamos por cargar el paquete:

``` r
library(perutranspaeconomica)
```

### Iniciar consulta

Para iniciar una consulta tan solo hace falta usar la función
`seguimiento_ep()`. Esto crea un dataframe vacío y muestra los
parámetros de consulta agregados. Al inicio no tenemos parámetros ni
data.

``` r
seguimiento_ep()
#> 
#> ── Seguimiento a la ejecucion presupuestal (actualizacion diaria) ──────────────
#> 
#> ── Parametros de consulta ──
#> 
#> ℹ No se ha definido parametros de consulta
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta
```

### Elegir parámetros de consulta

La elección de parámetros de consulta se hace con las funciones que
`elegir_*()`. Por ejemplo, para consultas en el módulo de gasto
presupuestal, se pueden utilizar las siguientes:

- `elegir_periodo_anual()`
- `elegir_quien_gasta()`
- `elegir_en_que_se_gasta()`
- `elegir_como_se_estructura()`
- `elegir_cuando_se_hizo_gasto()`
- `elegir_donde_se_gasta()`

De todas ellas, la mínima requerida es `elegir_periodo_anual()`.

Una vez que se le agrega parámetros a la consulta, la interfaz lo
refleja. `elegir_periodo_anual()` utiliza por defecto el año en curso

``` r
seguimiento_ep() |> 
    elegir_periodo_anual()
#> 
#> ── Seguimiento a la ejecucion presupuestal (actualizacion diaria) ──────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual:
#>   • 2022
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta
```

Cada argumento de las funciones `elegir_*()` puede aceptar vectores con
más de un elemento para una consulta más potente.

``` r
seguimiento_ep() |> 
    elegir_periodo_anual(periodo = 2020:2022)
#> 
#> ── Seguimiento a la ejecucion presupuestal (actualizacion diaria) ──────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual:
#>   • 2020, 2021 y 2022
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta
```

Sin embargo, en el resto de parámetros, es necesario que al menos un
argumento esté definido como `"todos"`. Más adelante se verá que en caso
contrario la consulta no prosperará.

``` r
# malo. dos argumentos definidos como "todos"
seguimiento_ep() |> 
    elegir_periodo_anual() |> 
    elegir_quien_gasta(nivel = "todos") |> 
    elegir_donde_se_gasta(departamento_meta = "todos")
```

``` r
# bueno. solo un argumento definido como "todos"
seguimiento_ep() |> 
    elegir_periodo_anual() |> 
    elegir_quien_gasta(nivel = "E") |> 
    elegir_donde_se_gasta(departamento_meta = "todos") 
#> 
#> ── Seguimiento a la ejecucion presupuestal (actualizacion diaria) ──────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual:
#>   • 2022
#> • Quien gasta:
#>   • Nivel de gobierno: E
#> • Donde se gasta:
#>   • Departamento (meta): todos
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta
```

Todos los métodos `elegir_*()` cuentan con documentación referente a
cómo deben ser definidos. Para mayor detalle consultar el método
específico. Por ejemplo, `help("elegir_quien_gasta")` o
`?elegir_quien_gasta`.

### Consultar

Una vez definidos los parámetros de la consulta, solo hace falta
ejecutarla. Para ello, usamos la función `consultar()`. Esto nos
devolverá la interfaz de consulta, pero ahora contendrá la data
requerida.

``` r
# ¿Cómo va la ejecución presupuestal por departamento en el gobierno nacional?
seguimiento_ep() |> 
    elegir_periodo_anual() |> 
    elegir_quien_gasta(nivel = "E") |> 
    elegir_donde_se_gasta(departamento_meta = "todos") |> 
    consultar()
#> ℹ Iniciando consulta
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> 
#> ── Seguimiento a la ejecucion presupuestal (actualizacion diaria) ──────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual:
#>   • 2022
#> • Quien gasta:
#>   • Nivel de gobierno: E
#> • Donde se gasta:
#>   • Departamento (meta): todos
#> 
#> ── Data ──
#> 
#> # A tibble: 26 × 13
#>    periodo cod_de…¹ desc_departamento_meta            pia    pim certi…² compr…³
#>      <int> <chr>    <chr>                           <dbl>  <dbl>   <dbl>   <dbl>
#>  1    2022 01       AMAZONAS                       1.03e9 1.07e9  1.02e9  9.61e8
#>  2    2022 02       ANCASH                         3.37e9 3.04e9  2.75e9  2.67e9
#>  3    2022 03       APURIMAC                       9.13e8 1.09e9  1.02e9  9.48e8
#>  4    2022 04       AREQUIPA                       2.19e9 2.20e9  2.12e9  2.05e9
#>  5    2022 05       AYACUCHO                       1.14e9 1.34e9  1.26e9  1.19e9
#>  6    2022 06       CAJAMARCA                      2.03e9 2.26e9  2.15e9  2.07e9
#>  7    2022 07       PROVINCIA CONSTITUCIONAL DEL … 2.72e9 3.07e9  2.95e9  2.78e9
#>  8    2022 08       CUSCO                          3.20e9 3.44e9  3.15e9  2.90e9
#>  9    2022 09       HUANCAVELICA                   1.06e9 9.60e8  8.59e8  8.24e8
#> 10    2022 10       HUANUCO                        1.64e9 1.61e9  1.50e9  1.43e9
#> # … with 16 more rows, 6 more variables: atencion_de_compromiso_mensual <dbl>,
#> #   devengado <dbl>, girado <dbl>, avance_percent <dbl>,
#> #   departamento_meta <chr>, nivel <chr>, and abbreviated variable names
#> #   ¹​cod_departamento_meta, ²​certificacion, ³​compromiso_anual
```

Se recomienda asignarle nombre a una consulta ejecutada para evitar
posibles tediosas re-descargas, especialmente cuando la consulta usa
parámetros con vectores más grandes.

``` r
# ¿Cómo se ejecutó el gasto por genérica para el PP 0031 entre el 2015 y 2021?
mi_consulta <- seguimiento_ep() |> 
    elegir_periodo_anual(2015:2021) |> 
    elegir_en_que_se_gasta(categoria_presupuestal = "0031") |> 
    elegir_como_se_estructura(generica = "todos") |> 
    consultar()
#> ℹ Iniciando consulta
#> ⠙ 2/7 ETA:  5s | Ejecutando consulta ⠹ 3/7 ETA:  4s | Ejecutando consulta ⠸ 4/7 ETA:  3s | Ejecutando consulta ⠼ 5/7 ETA:  2s | Ejecutando consulta ⠴ 6/7 ETA:  1s | Ejecutando consulta                                       ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas

mi_consulta
#> 
#> ── Seguimiento a la ejecucion presupuestal (actualizacion diaria) ──────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual:
#>   • 2015, 2016, 2017, 2018, 2019, 2020 y 2021
#> • En que se gasta:
#>   • Categoria presupuestal: 0031
#> • Como se estructura gasto:
#>   • Generica: todos
#> 
#> ── Data ──
#> # A tibble: 28 × 13
#>    periodo cod_ge…¹ desc_generica                     pia    pim certi…² compr…³
#>      <int> <chr>    <chr>                           <dbl>  <dbl>   <dbl>   <dbl>
#>  1    2015 5-21     PERSONAL Y OBLIGACIONES SOCIA… 1.62e8 1.62e8  1.62e8  1.62e8
#>  2    2015 5-23     BIENES Y SERVICIOS             1.04e8 8.25e7  7.89e7  7.79e7
#>  3    2015 5-25     OTROS GASTOS                   7   e6 7.93e6  7.93e6  7.93e6
#>  4    2015 6-26     ADQUISICION DE ACTIVOS NO FIN… 2.61e7 2.51e7  2.29e7  2.29e7
#>  5    2016 5-21     PERSONAL Y OBLIGACIONES SOCIA… 2.08e8 2.08e8  2.08e8  2.08e8
#>  6    2016 5-23     BIENES Y SERVICIOS             8.00e7 8.47e7  8.42e7  8.24e7
#>  7    2016 5-25     OTROS GASTOS                   7   e6 7.45e6  7.45e6  7.21e6
#>  8    2016 6-26     ADQUISICION DE ACTIVOS NO FIN… 0      2.15e6  2.15e6  1.32e6
#>  9    2017 5-21     PERSONAL Y OBLIGACIONES SOCIA… 2.09e8 2.09e8  2.09e8  2.09e8
#> 10    2017 5-23     BIENES Y SERVICIOS             8.42e7 9.08e7  8.89e7  8.77e7
#> # … with 18 more rows, 6 more variables: atencion_de_compromiso_mensual <dbl>,
#> #   devengado <dbl>, girado <dbl>, avance_percent <dbl>, generica <chr>,
#> #   categoria_presupuestal <chr>, and abbreviated variable names ¹​cod_generica,
#> #   ²​certificacion, ³​compromiso_anual
```

Nunca definir más de un parámetro de consulta como `"todos"` porque (por
ahora) producirá un incomprensible.

``` r
# malo. dos argumentos definidos como "todos"
seguimiento_ep() |> 
    elegir_periodo_anual() |> 
    elegir_quien_gasta(nivel = "todos") |> 
    elegir_donde_se_gasta(departamento_meta = "todos") |> 
    consultar()
#> ℹ Iniciando consulta
#> Error in `[[<-`(`*tmp*`, empty_str_name, value = empty_str_value): no such index at level 1
```

Una vez obtenida la consulta requerida, es posible tratar los datos
obtenidos como cualquier otro dataframe en R. Por ejemplo, para calcular
el porcentaje de presupuesto destinado a personal y obligaciones
sociales por periodo anual.

``` r
library(dplyr)

mi_consulta |> 
    select(periodo, desc_generica, pim) |> 
    group_by(periodo) |> 
    mutate(porc_presupuesto = (pim/sum(pim)*100) |> round(1)) |> 
    ungroup() |> 
    filter(desc_generica == "PERSONAL Y OBLIGACIONES SOCIALES")
#> # A tibble: 7 × 4
#>   periodo desc_generica                          pim porc_presupuesto
#>     <int> <chr>                                <dbl>            <dbl>
#> 1    2015 PERSONAL Y OBLIGACIONES SOCIALES 161903973             58.4
#> 2    2016 PERSONAL Y OBLIGACIONES SOCIALES 208113793             68.8
#> 3    2017 PERSONAL Y OBLIGACIONES SOCIALES 209308943             66.3
#> 4    2018 PERSONAL Y OBLIGACIONES SOCIALES 180890881             61.9
#> 5    2019 PERSONAL Y OBLIGACIONES SOCIALES 195441649             65.8
#> 6    2020 PERSONAL Y OBLIGACIONES SOCIALES 183923246             67.9
#> 7    2021 PERSONAL Y OBLIGACIONES SOCIALES 187842487             68.2
```

También es posible usar los datos obtenidos directamente para un gráfico
con `ggplot2`.

``` r
library(ggplot2)

mi_consulta |> 
    ggplot(aes(periodo, pim, color = cod_generica)) +
    geom_line() +
    scale_y_continuous(labels = scales::label_dollar(prefix = "S/."))
```

<img src="man/figures/README-unnamed-chunk-10-1.png" width="100%" />
