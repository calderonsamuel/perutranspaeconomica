
<!-- README.md is generated from README.Rmd. Please edit that file -->

# perutranspaeconomica

<!-- badges: start -->
<!-- badges: end -->

El objetivo de `{perutranspaeconomica}` es contar con una manera de
obtener datos del Portal de Transparencia Económica Perú desde R, con
una interfaz de programación consistente y clara.

## Aviso

Este paquete se encuentra aún en desarrollo, por lo que no se recomienda
implementarlo en producción.

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
remotes::install_github("calderonsamuel/perutranspaeconomica")
```

## Ejemplo

Con este paquete puedes realizar consultas del Portal de Transparencia
Económica del MEF-Perú, específicamente en el [módulo de gasto de
seguimiento a la ejecución
presupuestal](https://www.mef.gob.pe/es/?option=com_content&language=es-ES&Itemid=100944&lang=es-ES&view=article&id=504).

Empezamos por cargar el paquete:

``` r
library(perutranspaeconomica)
```

Tenemos dos maneras de usar el paquete. En primer lugar, podemos usar la
función `gasto()` para hacer una consulta directa. Por ejemplo, para
obtener el gasto ejecutado en todos los productos del programa
presupuestal “0031” en el 2021:

``` r
gasto(year = 2021, categoria_presupuestal = "0031", producto = "")
#> # A tibble: 5 × 11
#>    year cod_proyecto desc_proyecto     pia    pim certificacion compromiso_anual
#>   <dbl> <chr>        <chr>           <dbl>  <dbl>         <dbl>            <dbl>
#> 1  2021 2522056      ADQUISICION D… 0      2.18e5        217500           217500
#> 2  2021 3000001      ACCIONES COMU… 7.94e6 8.51e6       7903965          7846217
#> 3  2021 3000294      OPERACIONES D… 2.28e8 2.37e8     236004288        232303203
#> 4  2021 3000490      HECTAREAS RED… 1.99e7 1.98e7      19493169         19298659
#> 5  2021 3000492      PROCESOS JUDI… 7.46e6 1.01e7       9834095          9808935
#> # … with 4 more variables: atencion_de_compromiso_mensual <dbl>,
#> #   devengado <dbl>, girado <dbl>, avance_percent <dbl>
```

La segunda opción es componer primero la lista de parámetros y luego
ejecutar la consulta. Comenzamos por componer la lista:

``` r
make_gasto_query(year=2022, categoria_presupuestal = "0031", producto = "")
#> $y
#> [1] 2022
#> 
#> $`30`
#> [1] "0031"
#> 
#> $`31`
#> [1] ""
```

Como se puede ver, esto nos devuelve una lista nombrada en la que los
nombres corresponden con los parámetros de consulta tal y como están
definidos en la API del sistema del MEF. Además, componiendo la lista de
esta manera se aprovecha el autocompletado.

``` r
make_gasto_query(year=2022, categoria_presupuestal = "0031", producto = "") |> 
    perform_gasto_query()
```
