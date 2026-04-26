# Elección de parámetros

A pesar de que este paquete brinda una manera de interactuar con la
plataforma de seguimiento a la ejecución presupuestal, es necesario
mencionar que yo (el autor del paquete) no he tenido ningún tipo de
participación en el diseño, programación o mantenimiento de la
plataforma del MEF. La plataforma no parece haber sido diseñada pensando
en consultas fuera de su interfaz gráfica, que protege al usuario típico
de tener que conocer las maneras tan distintas en que se definen sus
parámetros, tanto en sus nombres como en sus valores esperados.

Pero si estás leyendo esto significa que la interfaz definida por el
equipo del MEF no es suficiente para tus propósitos, y tienes la
disposición necesaria para invertir un poco de esfuerzo para obtener la
gran recompensa de aprovechar de manera más eficiente la información de
la plataforma. Siéntete libre de consultar este documento cuantas veces
sea necesario.

A pesar de que este artículo se centra en mostrar ejemplos del módulo de
*gasto*, se sigue la misma lógica para las consultas al módulo de
*ingreso*.

## El flujo de trabajo

Como pasa con cualquier paquete en R, para usarlo debemos cargarlo.

``` r
library(perutranspaeconomica)
```

El flujo de trabajo propuesto por
[perutranspaeconomica](https://perutranspaeconomica.samuelenrique.com)
consiste en:

1.  Iniciar
2.  Elegir
3.  Consultar

Por lo pronto, iniciar no requiere más trabajo que el uso de
[`iniciar_transparencia_economica()`](https://perutranspaeconomica.samuelenrique.com/reference/iniciar_transparencia_economica.md).
Este documento busca explicar con mayor detalle la manera en que se
deben definir los parámetros pasados a las funciones `elegir_*()` para,
en combinación con
[`consultar()`](https://perutranspaeconomica.samuelenrique.com/reference/consultar.md),
poder hacer consultas exitosas.

La interacción con el sistema del MEF es mejor aprovechable si se tienen
conocimientos acerca de Sistema Nacional de Presupuesto Público. Para
ello, recomiendo la lectura del [Decreto Legislativo Nº 1440 Decreto
Legislativo del Sistema Nacional de Presupuesto
Público](https://www.gob.pe/institucion/mef/normas-legales/201360-1440).
En especial del sub capítulo II y III.

## Funciones de elección

El paquete permite especificar todas las consultas que se pueden hacer
desde la plataforma del MEF, del 2012 en adelante. A continuación se
explica cómo definir cada uno de los parámetros. En todos los casos se
hará uso de
[`consultar()`](https://perutranspaeconomica.samuelenrique.com/reference/consultar.md)
para ver la tabla consultada.

### Elegir periodo anual

Para esto usamos
[`elegir_periodo_anual()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_periodo_anual.md).
Toda consulta requiere que se defina el periodo anual. Cuando no se
especifica ningún año dentro de esta función, se usa por defecto el año
en curso.

``` r
iniciar_transparencia_economica() %>% 
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

Debido a que no estamos especificando ningún otro parámetro aún,
[`consultar()`](https://perutranspaeconomica.samuelenrique.com/reference/consultar.md)
nos devuelve los datos del presupuesto total. Es la misma información
que se obtiene al ingresar a la plataforma de manera normal.

Es posible especificar más de un año de consulta. Para ello basta con
especificar un vector numérico con los años que nos interesan.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(c(2012, 2014, 2016)) %>% 
    consultar()
#> ℹ Iniciando consulta
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> # A tibble: 3 × 10
#>   periodo total          pia          pim certificacion compromiso_anual
#>     <dbl> <chr>        <dbl>        <dbl>         <dbl>            <dbl>
#> 1    2012 TOTAL  95534635146 122380231023  104861677925     103676969380
#> 2    2014 TOTAL 118934253913 144805725965  131410018397     129777581135
#> 3    2016 TOTAL 138490511244 158282217927  144536534140     137792009934
#> # ℹ 4 more variables: atencion_de_compromiso_mensual <dbl>, devengado <dbl>,
#> #   girado <dbl>, avance_percent <dbl>
```

Cada sección que viene a continuación muestra un tipo de elección de
detalle con uno o dos gráficos que explican la posible *ruta* tomando en
cuenta los argumentos de la consulta. Al terminar de repasar cada tipo
de elección se aclarará a qué se hace referencia con “Consulta base”.

Para el resto de la explicación se omite mostrar la metadata de la
consulta para enfocarnos en los datos obtenidos.

### Elegir quién gasta

Esta función permite buscar la información de ejecución presupuestal
según el tipo de entidad que queremos consultar. En su grado más alto de
especificidad se puede llegar a diferenciar según Unidad Ejecutora,
Municipio o Mancomunidad. El gráfico muestra todos los elementos de
consulta intermedios a los que se puede acceder. Debe tenerse en cuenta
que una vez tomada una “ruta” de consulta no es posible acceder a otra.
Por ejemplo, no es posible consultar por pliego y departamento al mismo
tiempo.

A manera de ejemplo, si quisiéramos ver todos los niveles de gobierno
disponibles lo especificamos en el argumento `nivel`. Recuerda que
siempre es necesario usar
[`elegir_periodo_anual()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_periodo_anual.md).

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2022) %>% 
    elegir_quien_gasta(nivel = "todos") %>% 
    consultar()
#> # A tibble: 3 × 12
#>   periodo cod_nivel_de_gobierno desc_nivel_de_gobierno          pia          pim
#>     <dbl> <chr>                 <chr>                         <dbl>        <dbl>
#> 1    2022 E                     GOBIERNO NACIONAL      139099209295 134800977215
#> 2    2022 M                     GOBIERNOS LOCALES       21572594607  52886839768
#> 3    2022 R                     GOBIERNOS REGIONALES    36330465112  50382364455
#> # ℹ 7 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, nivel <chr>
```

Con esto podemos ver que existen tres niveles de gobierno. En caso se
escoja profundizar la consulta por Gobierno Nacional o Gobiernos
Regionales se estaría tomando el camino de Sector. En este caso,
escogemos Gobierno Nacional para ver el presupuesto por sector. Para
ello, usamos el código del nivel de gobierno escogido. Nótese que para
mayor comodidad en el procesamiento de los datos, se incluyen columnas
extras con la metadata de la consulta.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2022) %>% 
    elegir_quien_gasta(nivel = "E", sector = "todos") %>% 
    consultar()
#> # A tibble: 30 × 13
#>    periodo cod_sector desc_sector                           pia         pim
#>      <dbl> <chr>      <chr>                               <dbl>       <dbl>
#>  1    2022 01         PRESIDENCIA CONSEJO MINISTROS  7755356930  5868630182
#>  2    2022 03         CULTURA                         606374213   615384354
#>  3    2022 04         PODER JUDICIAL                 3185867103  3169460209
#>  4    2022 05         AMBIENTAL                       794397975   751245011
#>  5    2022 06         JUSTICIA                       1854961785  2126341231
#>  6    2022 07         INTERIOR                      10880820467 13924845983
#>  7    2022 08         RELACIONES EXTERIORES           848424011   987788424
#>  8    2022 09         ECONOMIA Y FINANZAS           42688806017 34974113894
#>  9    2022 10         EDUCACION                     17250060955 13222235791
#> 10    2022 11         SALUD                         11527638911 13076347305
#> # ℹ 20 more rows
#> # ℹ 8 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, nivel <chr>, sector <chr>
```

Ahora que se sabe cuáles son los sectores que conforman al gobierno
nacional, podemos priorizar conocer la ejecución de alguno en
específico. Por ejemplo, el sector salud. Para ello, actualizamos
nuestros parámetros de búsqueda indicando el código del sector
correspondiente y especificando conocer todos los pliegos que lo
conforman.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2022) %>% 
    elegir_quien_gasta(nivel = "E", sector = "11", pliego = "todos") %>% 
    consultar()
#> # A tibble: 5 × 14
#>   periodo cod_pliego desc_pliego                        pia    pim certificacion
#>     <dbl> <chr>      <chr>                            <dbl>  <dbl>         <dbl>
#> 1    2022 011        M. DE SALUD                     8.64e9 9.90e9    9319542553
#> 2    2022 131        INSTITUTO NACIONAL DE SALUD     1.33e8 1.48e8     138496300
#> 3    2022 134        SUPERINTENDENCIA NACIONAL DE S… 5.73e7 5.85e7      57624751
#> 4    2022 135        SEGURO INTEGRAL DE SALUD        2.40e9 2.48e9    2464060821
#> 5    2022 136        INSTITUTO NACIONAL DE ENFERMED… 2.95e8 4.82e8     425775210
#> # ℹ 8 more variables: compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, nivel <chr>, sector <chr>, pliego <chr>
```

Con esto, ahora podemos ver que el sector salud está conformado por
cinco pliegos. Puede que ahora querramos ver los datos de las unidades
ejecutoras del Ministerio de salud. Nuevamente, especificamos esto en la
consulta.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2022) %>% 
    elegir_quien_gasta(nivel = "E", sector = "11", pliego = "011", unidad_ejecutora = "todos") %>% 
    consultar()
#> # A tibble: 34 × 15
#>    periodo cod_unidad_ejecutora desc_unidad_ejecutora                 pia    pim
#>      <dbl> <chr>                <chr>                               <dbl>  <dbl>
#>  1    2022 001-117              ADMINISTRACION CENTRAL - MINSA     2.97e9 1.75e9
#>  2    2022 005-121              INSTITUTO NACIONAL DE SALUD MENTAL 4.01e7 6.37e7
#>  3    2022 007-123              INSTITUTO NACIONAL DE CIENCIAS NE… 4.91e7 7.44e7
#>  4    2022 008-124              INSTITUTO NACIONAL DE OFTALMOLOGIA 4.07e7 6.18e7
#>  5    2022 009-125              INSTITUTO NACIONAL DE REHABILITAC… 3.89e7 5.35e7
#>  6    2022 010-126              INSTITUTO NACIONAL DE SALUD DEL N… 1.85e8 2.69e8
#>  7    2022 011-127              INSTITUTO NACIONAL MATERNO PERINA… 1.20e8 1.87e8
#>  8    2022 016-132              HOSPITAL NACIONAL HIPOLITO UNANUE  1.50e8 2.63e8
#>  9    2022 017-133              HOSPITAL HERMILIO VALDIZAN         4.02e7 5.65e7
#> 10    2022 020-136              HOSPITAL SERGIO BERNALES           8.49e7 1.29e8
#> # ℹ 24 more rows
#> # ℹ 10 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, nivel <chr>, sector <chr>, pliego <chr>,
#> #   unidad_ejecutora <chr>
```

Este ha sido el nivel de detalle más profundo que brinda la consulta por
esta ruta. El ejercicio es muy similar si se quiere obtener los datos
por municipio. Por ejemplo, para conocer los datos de los distritos de
la provincia de Cangallo, región Ayacucho.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2022) %>% 
    elegir_quien_gasta(nivel = "M", goblocal_o_manc = "M", departamento = "05", provincia = "02", municipalidad = "todos") %>% 
    consultar()
#> # A tibble: 6 × 16
#>   periodo cod_municipalidad desc_municipalidad                        pia    pim
#>     <dbl> <chr>             <chr>                                   <dbl>  <dbl>
#> 1    2022 050201-300454     MUNICIPALIDAD PROVINCIAL DE CANGALLO   8.42e6 1.98e7
#> 2    2022 050202-300455     MUNICIPALIDAD DISTRITAL DE CHUSCHI     3.18e6 2.97e7
#> 3    2022 050203-300456     MUNICIPALIDAD DISTRITAL DE LOS MOROCH… 1.83e7 3.54e7
#> 4    2022 050204-300457     MUNICIPALIDAD DISTRITAL DE MARIA PARA… 1.12e6 1.08e7
#> 5    2022 050205-300458     MUNICIPALIDAD DISTRITAL DE PARAS       2.84e6 2.03e7
#> 6    2022 050206-300459     MUNICIPALIDAD DISTRITAL DE TOTOS       1.32e6 1.03e7
#> # ℹ 11 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, nivel <chr>, goblocal_o_manc <chr>,
#> #   departamento <chr>, provincia <chr>, municipalidad <chr>
```

### Elegir en qué se gasta

Para esta consulta hace falta encadenar la función
[`elegir_en_que_se_gasta()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_destino.md).
El sistema de consulta amigable del MEF permite buscar según dos tipos
de clasificación, la función mencionada combina ambas clasificaciones en
un solo paso (simulando la manera en que funciona la interfaz del MEF).
A continuación una explicación de la lógica de la búsqueda, cabe
mencionar que esta es la parte que puede resultar más complicada de
entender, pero se incluye un ejemplo integrador para ilustrar mejor la
explicación.

En primer lugar, se puede buscar los gastos según su Clasificación
Programática. Aquí se empieza definiendo la Categoría Presupuestal, en
la que luego se puede especificar el Producto o proyecto. También es
posible finalmente buscar las actividades o acciones de inversión u
obra. Cabe recordar que esta clasificación está vinculado a los
Programas Presupuestales (cada categoría presupuestal corresponde con un
programa presupuestal. Podríamos decir que esta clasificación trata de
responder las siguientes preguntas:

- Categoría Presupuestal: ¿qué oportunidad de mejora quiero atender en
  la población? o ¿qué problema de la población quiero resolver o
  mitigar?

- Producto: ¿qué bienes o servicios puedo entregar a la población para
  atender o mitigar el problema identificado?

- Actividad: ¿qué voy a hacer de manera más específica para lograr
  brindar esos bienes o servicios?

La segunda clasificación es la Funcional, en la que es posible llegar
hasta el detalle de grupo funcional. En otras palabras, ” constituye una
clasificación detallada de las funciones a cargo del Estado y tiene por
objeto facilitar el seguimiento, exposición y análisis de las tendencias
del gasto público respecto a las principales funciones del
Estado”[¹](#fn1).

Habiendo llegado hasta el nivel de detalle de Actividad según la
Clasificación Programática y al mismo tiempo hasta el nivel de Grupo
Funcional según la Clasificación Funcional, es posible obtener la
información de la Meta Presupuestaria, que indica cómo se mide el avance
de lo programado.

A continuación un ejemplo para ilustrar la explicación. Empezamos viendo
las categorías presupuestales. Recordemos que estas se nombran (o al
menos se deberían nombrar) como una acción respecto a un problema a
resolver. En este caso hacemos la búsqueda para el 2021.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_en_que_se_gasta(categoria_presupuestal = "todos") %>%
    consultar()
#> # A tibble: 92 × 12
#>    periodo cod_categoria_presupue…¹ desc_categoria_presupuestal       pia    pim
#>      <dbl> <chr>                    <chr>                           <dbl>  <dbl>
#>  1    2021 0001                     PROGRAMA ARTICULADO NUTRICION… 2.39e9 2.90e9
#>  2    2021 0002                     SALUD MATERNO NEONATAL         1.92e9 2.33e9
#>  3    2021 0016                     TBC-VIH/SIDA                   7.13e8 6.92e8
#>  4    2021 0017                     ENFERMEDADES METAXENICAS Y ZO… 3.61e8 4.09e8
#>  5    2021 0018                     ENFERMEDADES NO TRANSMISIBLES  6.04e8 7.23e8
#>  6    2021 0024                     PREVENCION Y CONTROL DEL CANC… 5.26e8 7.91e8
#>  7    2021 0030                     REDUCCION DE DELITOS Y FALTAS… 4.54e9 5.05e9
#>  8    2021 0031                     REDUCCION DEL TRAFICO ILICITO… 2.63e8 2.76e8
#>  9    2021 0032                     LUCHA CONTRA EL TERRORISMO     3.03e8 3.09e8
#> 10    2021 0036                     GESTION INTEGRAL DE RESIDUOS … 1.49e9 2.39e9
#> # ℹ 82 more rows
#> # ℹ abbreviated name: ¹​cod_categoria_presupuestal
#> # ℹ 7 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, categoria_presupuestal <chr>
```

Vemos que para el 2021 se definieron 92 categorías presupuestales.
Sabemos que en el país se produce una alta cantidad de drogas
cocaínicas, así que nos interesa ver qué productos se han definido para
el Programa Presupuestal 0031 “Reducción del tráfico ilícito de drogas”.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_en_que_se_gasta(categoria_presupuestal = "0031", producto =  "todos") %>%
    consultar() 
#> Warning: There was 1 warning in `dplyr::filter()`.
#> ℹ In argument: `!is.na(readr::parse_number(.data$certificacion))`.
#> Caused by warning:
#> ! 1 parsing failure.
#> row col expected                                    actual
#>   2  -- a number Sistema de Seguimiento de Inversiones SSI
#> # A tibble: 5 × 13
#>   periodo cod_proyecto desc_proyecto                                  pia    pim
#>     <dbl> <chr>        <chr>                                        <dbl>  <dbl>
#> 1    2021 2522056      ADQUISICION DE VEHICULO; EN EL(LA) UNIDAD … 0      2.18e5
#> 2    2021 3000001      ACCIONES COMUNES                            7.94e6 8.51e6
#> 3    2021 3000294      OPERACIONES DE INTERDICCION CONTRA EL TRAF… 2.28e8 2.37e8
#> 4    2021 3000490      HECTAREAS REDUCIDAS DE CULTIVOS ILICITOS D… 1.99e7 1.98e7
#> 5    2021 3000492      PROCESOS JUDICIALES CON INTERVENCION DE LA… 7.46e6 1.01e7
#> # ℹ 8 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, categoria_presupuestal <chr>, producto <chr>
```

La tabla obtenida nos muestra información de los productos de este
programa presupuestal, pero también de proyectos de inversión
vinculados. Podemos reconocer los productos porque cuentan con una
codificación que empieza con “30”. Debido a que el insumo de primordial
es la hoja de coca, nos interesa ver qué presupuesto tienen las
actividades que se hacen para reducir los cultivos ilícitos. La tabla
nos muestra que dicho producto cuenta con código “3000490”.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_en_que_se_gasta(
        categoria_presupuestal = "0031", 
        producto =  "3000490", 
        actividad = "todos"
    ) %>%
    consultar()
#> # A tibble: 4 × 14
#>   periodo cod_actividad_accion_de…¹ desc_actividad_accion_de_inv…²    pia    pim
#>     <dbl> <chr>                     <chr>                           <dbl>  <dbl>
#> 1    2021 5003057                   OPERACIONES DE SEGURIDAD PARA… 4.97e6 5.87e6
#> 2    2021 5004070                   REDUCCION DE HECTAREAS DE PLA… 1   e6 0     
#> 3    2021 5004072                   SOPORTE AEREO PARA LA REDUCCI… 1.28e7 1.32e7
#> 4    2021 5004970                   ASISTENCIA A LA POBLACION POR… 1.17e6 7.12e5
#> # ℹ abbreviated names: ¹​cod_actividad_accion_de_inversion_obra,
#> #   ²​desc_actividad_accion_de_inversion_obra
#> # ℹ 9 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, categoria_presupuestal <chr>, producto <chr>,
#> #   actividad <chr>
```

La nueva consulta nos indica que la actividad específica de “Reducción
de hectáreas de plantaciones ilegales” contó con un presupuesto
institucional de apertura de 1000000 de soles, de los cuales se tiene 0%
de avance. Esto no significa que el Estado el 2021 no haya usado su
presupuesto disponible para reducir los cultivos ilegales, podemos ver
que el resto de actividades del producto tienen valores superiores al
88% en todos los casos.

Es posible consultar el mismo tema a través de la clasificación
funcional. Empecemos viendo todas las funciones del 2021.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_en_que_se_gasta(funcion = "todos") %>% 
    consultar()
#> # A tibble: 25 × 12
#>    periodo cod_funcion desc_funcion                                  pia     pim
#>      <dbl> <chr>       <chr>                                       <dbl>   <dbl>
#>  1    2021 01          LEGISLATIVA                               6.15e 8 6.11e 8
#>  2    2021 02          RELACIONES EXTERIORES                     7.60e 8 9.95e 8
#>  3    2021 03          PLANEAMIENTO, GESTION Y RESERVA DE CONTI… 2.41e10 2.23e10
#>  4    2021 04          DEFENSA Y SEGURIDAD NACIONAL              4.98e 9 5.57e 9
#>  5    2021 05          ORDEN PUBLICO Y SEGURIDAD                 1.06e10 1.26e10
#>  6    2021 06          JUSTICIA                                  6.93e 9 6.96e 9
#>  7    2021 07          TRABAJO                                   5.16e 8 3.63e 9
#>  8    2021 08          COMERCIO                                  5.23e 8 7.16e 8
#>  9    2021 09          TURISMO                                   4.38e 8 6.49e 8
#> 10    2021 10          AGROPECUARIA                              8.75e 9 7.11e 9
#> # ℹ 15 more rows
#> # ℹ 7 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, funcion <chr>
```

En este caso obtenemos 25 resultados, que corresponden con las funciones
principales del Estado. Este listado puede ayudar a entender mejor la
diferencia con el otro tipo de clasificación.

La Clasificación Programática divide el presupuesto de acuerdo a los
problemas que el Estado tiene que atender. Dichos problemas pueden ir
variando con el tiempo, se pueden mitigar o pueden aparecer nuevos más
urgentes. Por ejemplo, si de pronto la seguridad ciudadana se viera
amenazada constantemente por el avance de pandillas y crimenes asociados
a ellas, se podría pensar en incluir un programa para mitigar esto. Como
en la actualidad no se considera ello como problema público, no existe
dentro de la Clasificación Programática.

En cambio, la Clasificación Funcional abarca las funciones primordiales
del Estado, aquellas que como ciudadanos no podemos dejar de percibir.
Esto es, independientemente de cuáles sean los problemas específicos
pendientes de solucionar, el Estado no puede dejar de brindarnos Orden
Público, Seguridad, Justicia, o Legislación, por nombrar algunas
funciones.

Para seguir con el ejemplo, el tema del tráfico ilícito de drogas se
aborda dentro de la Función Orden Público y Seguridad (código 05).
Procedemos con la consulta para conocer las divisiones funcionales.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_en_que_se_gasta(
        funcion = "05",
        division_funcional = "todos"
    ) %>% 
    consultar()
#> # A tibble: 8 × 13
#>   periodo cod_division_funcional desc_division_funcional              pia    pim
#>     <dbl> <chr>                  <chr>                              <dbl>  <dbl>
#> 1    2021 004                    PLANEAMIENTO GUBERNAMENTAL        8.53e7 6.67e7
#> 2    2021 006                    GESTION                           1.37e9 1.41e9
#> 3    2021 011                    TRANSFERENCIAS E INTERMEDIACION … 4.08e7 6.24e7
#> 4    2021 014                    ORDEN INTERNO                     7.67e9 8.37e9
#> 5    2021 015                    CONTROL DE DROGAS                 4.50e8 5.04e8
#> 6    2021 016                    GESTION DE RIESGOS Y EMERGENCIAS  9.37e8 2.18e9
#> 7    2021 018                    SEGURIDAD JURIDICA                2.21e7 2.49e7
#> 8    2021 051                    ASISTENCIA SOCIAL                 2.72e6 2.03e6
#> # ℹ 8 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, funcion <chr>, division_funcional <chr>
```

En las divisiones funcionales podemos ver de manera más específica
aquello que el Estado debe brindar en relación al Orden Interno y
Seguridad. Nuevamente vemos que independientemente de los problemas
existentes, un Estado debe ser capaz de proveer Asistencia Social,
Seguridad Jurídica, Gestión de Riesgos y Emergencias, entre otras cosas.
Podemos suponer que el tráfico ilícito de drogas se abarca dentro del
Control de drogas (código 015). Procedemos a consultar sus grupos
funcionales.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_en_que_se_gasta(
        funcion = "05", 
        division_funcional = "015",
        grupo_funcional = "todos"
    ) %>%
    consultar()
#> # A tibble: 3 × 14
#>   periodo cod_grupo_funcional desc_grupo_funcional                    pia    pim
#>     <dbl> <chr>               <chr>                                 <dbl>  <dbl>
#> 1    2021 0032                DESARROLLO ALTERNATIVO               9.78e7 1.41e8
#> 2    2021 0033                PREVENCION Y REHABILITACION          8.46e6 7.84e6
#> 3    2021 0034                INTERDICCION, LAVADO DE DINERO Y DE… 3.43e8 3.55e8
#> # ℹ 9 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, funcion <chr>, division_funcional <chr>,
#> #   grupo_funcional <chr>
```

De esta manera, podemos ver que en la división funcional Control de
Drogas, se tiene los grupos funcionales “Desarrollo alternativo”,
“Prevención y Rehabilitación”, e “Interdicción, lavado de dinero y
delitos conexos”.

En este punto, podemos empezar a consultar también según la
Clasificación Programática. Recordemos que estábamos consultando acerca
de la reducción de cultivos ilícitos. En los grupos funcionales
encontrados, el de “Interdicción, lavado de dinero y delitos conexos”
parece más relacionado. Veamos qué programas presupuestales abordan este
grupo funcional.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_en_que_se_gasta(
        funcion = "05", 
        division_funcional = "015",
        grupo_funcional = "0034",
        categoria_presupuestal = "todos"
    ) %>%
    consultar()
#> # A tibble: 2 × 15
#>   periodo cod_categoria_presupues…¹ desc_categoria_presupuestal       pia    pim
#>     <dbl> <chr>                     <chr>                           <dbl>  <dbl>
#> 1    2021 0031                      REDUCCION DEL TRAFICO ILICITO… 2.56e8 2.65e8
#> 2    2021 0074                      GESTION INTEGRADA Y EFECTIVA … 8.75e7 8.99e7
#> # ℹ abbreviated name: ¹​cod_categoria_presupuestal
#> # ℹ 10 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, categoria_presupuestal <chr>, funcion <chr>,
#> #   division_funcional <chr>, grupo_funcional <chr>
```

Vemos que son dos. En este punto, no debería causar sorpresa que uno de
ellos sea el Programa Presupuestal 0031 que vimos anteriormente. Podemos
seguir viendo cuáles de sus productos son abordados en el grupo
funcional.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_en_que_se_gasta(
        funcion = "05", 
        division_funcional = "015",
        grupo_funcional = "0034",
        categoria_presupuestal = "0031",
        producto = "todos"
    ) %>%
    consultar()
#> Warning: There was 1 warning in `dplyr::filter()`.
#> ℹ In argument: `!is.na(readr::parse_number(.data$certificacion))`.
#> Caused by warning:
#> ! 1 parsing failure.
#> row col expected                                    actual
#>   2  -- a number Sistema de Seguimiento de Inversiones SSI
#> # A tibble: 4 × 16
#>   periodo cod_proyecto desc_proyecto                                  pia    pim
#>     <dbl> <chr>        <chr>                                        <dbl>  <dbl>
#> 1    2021 2522056      ADQUISICION DE VEHICULO; EN EL(LA) UNIDAD … 0      2.18e5
#> 2    2021 3000001      ACCIONES COMUNES                            7.94e6 8.51e6
#> 3    2021 3000294      OPERACIONES DE INTERDICCION CONTRA EL TRAF… 2.28e8 2.37e8
#> 4    2021 3000490      HECTAREAS REDUCIDAS DE CULTIVOS ILICITOS D… 1.99e7 1.98e7
#> # ℹ 11 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, categoria_presupuestal <chr>, producto <chr>,
#> #   funcion <chr>, division_funcional <chr>, grupo_funcional <chr>
```

A diferencia de cuando consultamos partiendo sólo de la Clasificación
Programática, vemos que el grupo funcional escogido no incluye el
producto de “PROCESOS JUDICIALES CON INTERVENCION DE LA PROCURADURIA
PUBLICA CONTRA EL TRAFICO ILICITO DE DROGAS Y LAVADO DE ACTIVOS”.
Lógicamente, podemos ver qué actividades de la reducción de cultivos
ilícitos se incluyen.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_en_que_se_gasta(
        funcion = "05", 
        division_funcional = "015",
        grupo_funcional = "0034",
        categoria_presupuestal = "0031",
        producto = "3000490",
        actividad = "todos"
    ) %>%
    consultar()
#> # A tibble: 4 × 17
#>   periodo cod_actividad_accion_de…¹ desc_actividad_accion_de_inv…²    pia    pim
#>     <dbl> <chr>                     <chr>                           <dbl>  <dbl>
#> 1    2021 5003057                   OPERACIONES DE SEGURIDAD PARA… 4.97e6 5.87e6
#> 2    2021 5004070                   REDUCCION DE HECTAREAS DE PLA… 1   e6 0     
#> 3    2021 5004072                   SOPORTE AEREO PARA LA REDUCCI… 1.28e7 1.32e7
#> 4    2021 5004970                   ASISTENCIA A LA POBLACION POR… 1.17e6 7.12e5
#> # ℹ abbreviated names: ¹​cod_actividad_accion_de_inversion_obra,
#> #   ²​desc_actividad_accion_de_inversion_obra
#> # ℹ 12 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, categoria_presupuestal <chr>, producto <chr>,
#> #   actividad <chr>, funcion <chr>, division_funcional <chr>,
#> #   grupo_funcional <chr>
```

Vemos que dentro del grupo funcional se incluyen todas las actividades
del producto, así como todo el presupuesto. Puede parecer redundante,
pero hacer todo este camino es esencial para identificar el presupuesto
asignado a cada meta de las actividades. En este caso, veremos las metas
de la actividad “5003057 Operaciones de seguridad para la reducción de
las áreas de cultivo ilícito” que tuvo una ejecución del 94.7%.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_en_que_se_gasta(
        funcion = "05", 
        division_funcional = "015",
        grupo_funcional = "0034",
        categoria_presupuestal = "0031",
        producto = "3000490",
        actividad = "5003057",
        meta = "todos"
    ) %>%
    consultar()
#> # A tibble: 2 × 18
#>   periodo cod_meta   desc_meta                          pia    pim certificacion
#>     <dbl> <chr>      <chr>                            <dbl>  <dbl>         <dbl>
#> 1    2021 00001-1343 OPERACIONES DE SEGURIDAD PARA … 4.97e6 5.87e6       5694131
#> 2    2021 Cantidad   736.0Unidad de Medida: OPERACI… 7.36e2 7.36e2           736
#> # ℹ 12 more variables: compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, categoria_presupuestal <chr>, producto <chr>,
#> #   actividad <chr>, funcion <chr>, division_funcional <chr>,
#> #   grupo_funcional <chr>, meta <chr>
```

En este caso, la tabla nos muestra que la meta fueron 736 Operaciones,
de las cuales se tuvo un avance físico de 228 (31%). En otras palabras,
a pesar de un buen alto nivel de ejecución presupuestal, el avance
físico fue bajo. En este punto cabe preguntarse cómo se calculó la
correspondencia entre las metas y el presupuesto, que puede dar pie a
una investigación más profunda.

### Elegir con qué se financian los gastos

El sistema del MEF permite conocer de dónde proviene el presupuesto que
las entidades utilizan. Esto corresponde a la Clasificación por Fuentes
de Financiamiento de los ingresos públicos.

Para ilustrar este punto, veamos aporta el canon al presupuesto
nacional. Recordemos que el presupuesto total del 2021.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    consultar()
#> # A tibble: 1 × 10
#>   periodo total          pia          pim certificacion compromiso_anual
#>     <dbl> <chr>        <dbl>        <dbl>         <dbl>            <dbl>
#> 1    2021 TOTAL 183029770158 227932217391  212450014781     205013665381
#> # ℹ 4 more variables: atencion_de_compromiso_mensual <dbl>, devengado <dbl>,
#> #   girado <dbl>, avance_percent <dbl>
```

En términos de Presupuesto Institucional Modificado, el Estado contó con
227932 217930 soles en el 2021. Para llegar a la cifra del canon
empezamos consultando qué Fuentes de financiamiento tuvo el Estado en el
2021.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_con_que_se_financia(fuente_financiamiento = "todos") %>% 
    consultar()
#> # A tibble: 5 × 12
#>   periodo cod_fuente_de_financi…¹ desc_fuente_de_financiamiento      pia     pim
#>     <dbl> <chr>                   <chr>                            <dbl>   <dbl>
#> 1    2021 1                       RECURSOS ORDINARIOS            9.95e10 1.08e11
#> 2    2021 2                       RECURSOS DIRECTAMENTE RECAUDA… 1.25e10 1.63e10
#> 3    2021 3                       RECURSOS POR OPERACIONES OFIC… 4.77e10 6.12e10
#> 4    2021 4                       DONACIONES Y TRANSFERENCIAS    4.76e 8 5.56e 9
#> 5    2021 5                       RECURSOS DETERMINADOS          2.28e10 3.67e10
#> # ℹ abbreviated name: ¹​cod_fuente_de_financiamiento
#> # ℹ 7 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, fuente_financiamiento <chr>
```

El canon es un recurso que por Ley le corresponde a los gobiernos
locales y regionales[²](#fn2). Debido a ello, forma parte de la Fuente
de financiamiento Recursos Determinados (código 5). Consultamos los
rubros que la conforman.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_con_que_se_financia(
        fuente_financiamiento = "5",
        rubro = "todos"
    ) %>% 
    consultar()
#> # A tibble: 4 × 13
#>   periodo cod_rubro desc_rubro                         pia     pim certificacion
#>     <dbl> <chr>     <chr>                            <dbl>   <dbl>         <dbl>
#> 1    2021 04        CONTRIBUCIONES A FONDOS         7.14e9 7.18e 9    7169823224
#> 2    2021 07        FONDO DE COMPENSACION MUNICIPAL 5.14e9 8.50e 9    7673465545
#> 3    2021 08        IMPUESTOS MUNICIPALES           3.19e9 3.94e 9    3559020005
#> 4    2021 18        CANON Y SOBRECANON, REGALIAS, … 7.38e9 1.71e10   14366541121
#> # ℹ 7 more variables: compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, fuente_financiamiento <chr>, rubro <chr>
```

Se puede ver que el rubro de “Canon y Sobrecanon, regalías, renta de
aduanas y participaciones” financió 17116846439 soles del presupuesto de
2021. Para mayor detalle se puede consultar el tipo de recurso.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_con_que_se_financia(
        fuente_financiamiento = "5",
        rubro = "18",
        tipo_de_recurso = "todos"
    ) %>% 
    consultar()
#> # A tibble: 49 × 14
#>    periodo cod_tipo_de_recurso desc_tipo_de_recurso                    pia   pim
#>      <dbl> <chr>               <chr>                                 <dbl> <dbl>
#>  1    2021 A                   REGALIAS MINERAS                          0     0
#>  2    2021 B                   RENTAS DE ADUANA                          0     0
#>  3    2021 C                   PARTICIPACIONES - DNTP                    0     0
#>  4    2021 D                   SUB CUENTA - PARTICIPACIONES - DNTP       0     0
#>  5    2021 E                   SUBCUENTA - PARTICIPACIONES - FONIPR…     0     0
#>  6    2021 F                   FFAA Y POLICIA NACIONAL                   0     0
#>  7    2021 G                   FOCAM                                     0     0
#>  8    2021 H                   SUB CUENTA - CANON MINERO                 0     0
#>  9    2021 I                   SUB CUENTA - CANON HIDROENERGETICO        0     0
#> 10    2021 J                   SUB CUENTA - CANON PESQUERO               0     0
#> # ℹ 39 more rows
#> # ℹ 9 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, fuente_financiamiento <chr>, rubro <chr>,
#> #   tipo_de_recurso <chr>
```

Es así que se puede comprobar que a pesar de que se consideran varios
tipos de recurso en este Rubro, el único que cuenta con información es
el de Canon, que representa el 100% del rubro, lo que nos permite
responder la pregunta planteada.

``` r
17116846439/227932217930*100
#> [1] 7.509621
```

El canon representó el 7.5% del presupuesto nacional en el 2021.

### Elegir cómo se estructura el gasto

En esta sección nos referimos a la Clasificación Económica. En otras
palabras, se muestra la manera en que los gastos se organizan según su
naturaleza económica. Por ejemplo, pagos de salarios, pagos de deudas,
pagos de obligaciones sociales, compra de inmuebles, donaciones, etc.

Para ilustrar esta clasificación voy a reproducir el camino para
determinar cuánto se gastó el 2021 en personal CAS. Se empieza por ver
las genéricas de gasto.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_como_se_estructura_gasto(generica = "todos") %>% 
    consultar()
#> # A tibble: 12 × 12
#>    periodo cod_generica desc_generica                                pia     pim
#>      <dbl> <chr>        <chr>                                      <dbl>   <dbl>
#>  1    2021 5-20         RESERVA DE CONTINGENCIA                  5.78e 9 4.69e 8
#>  2    2021 5-21         PERSONAL Y OBLIGACIONES SOCIALES         5.16e10 5.21e10
#>  3    2021 5-22         PENSIONES Y OTRAS PRESTACIONES SOCIALES  1.41e10 1.45e10
#>  4    2021 5-23         BIENES Y SERVICIOS                       3.73e10 5.17e10
#>  5    2021 5-24         DONACIONES Y TRANSFERENCIAS              4.06e 9 7.32e 9
#>  6    2021 5-25         OTROS GASTOS                             6.92e 9 2.20e10
#>  7    2021 6-20         RESERVA DE CONTINGENCIA                  1.95e 9 1.53e 8
#>  8    2021 6-24         DONACIONES Y TRANSFERENCIAS              4.62e 9 4.01e 9
#>  9    2021 6-25         OTROS GASTOS                             1.12e 8 2.12e 8
#> 10    2021 6-26         ADQUISICION DE ACTIVOS NO FINANCIEROS    4.02e10 5.79e10
#> 11    2021 6-27         ADQUISICION DE ACTIVOS FINANCIEROS       4.69e 8 1.09e 9
#> 12    2021 7-28         SERVICIO DE LA DEUDA PUBLICA             1.60e10 1.64e10
#> # ℹ 7 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, generica <chr>
```

En este punto podríamos cometer el error de continuar la búsqueda en la
genérica de Personal y Obligaciones Sociales, pero en realidad los CAS
forman parte de la genérica de Bienes y Servicios. Los trabajadores del
Estado Peruano tienen muy variados regímenes laborales, y no es
propósito de este documento discutirlos a detalle. Para seguir
continuar, consultamos por las subgenéricas de Bienes y Servicios.
Nótese que el código “5-23” debe ingresarse como “5-2-3”.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_como_se_estructura_gasto(
        generica = "5-2-3", 
        subgenerica = "todos"
    ) %>% 
    consultar()
#> # A tibble: 2 × 13
#>   periodo cod_sub_generica desc_sub_generica                 pia         pim
#>     <dbl> <chr>            <chr>                           <dbl>       <dbl>
#> 1    2021 1                COMPRA DE BIENES           6193282945  8904895030
#> 2    2021 2                CONTRATACION DE SERVICIOS 31096615468 42807531841
#> # ℹ 8 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, generica <chr>, subgenerica <chr>
```

Continuamos con la búsqueda escogiendo la subgenérica “Contratación de
Servicios”. Nótese que el código de subgenérica debe añadirse al código
de la genérica omitiendo el primer número. Lamentablemente, el sistema
del MEF ha establecido así su manera de construir las consultas y haría
falta mucho esfuerzo por cambiarlo.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_como_se_estructura_gasto(
        generica = "5-2-3", 
        subgenerica = "2-3-2",
        detalle_subgenerica = "todos"
    ) %>% 
    consultar()
#> # A tibble: 9 × 14
#>   periodo cod_detalle_sub_gener…¹ desc_detalle_sub_generica          pia     pim
#>     <dbl> <chr>                   <chr>                            <dbl>   <dbl>
#> 1    2021 1                       VIAJES                         9.90e 8 9.77e 8
#> 2    2021 2                       SERVICIOS BASICOS, COMUNICACI… 2.31e 9 2.32e 9
#> 3    2021 3                       SERVICIOS DE LIMPIEZA, SEGURI… 1.58e 9 1.61e 9
#> 4    2021 4                       SERVICIO DE MANTENIMIENTO, AC… 4.05e 9 6.27e 9
#> 5    2021 5                       ALQUILERES DE MUEBLES E INMUE… 9.03e 8 1.57e 9
#> 6    2021 6                       SERVICIOS ADMINISTRATIVOS, FI… 1.12e 9 9.92e 8
#> 7    2021 7                       SERVICIOS PROFESIONALES Y TEC… 8.01e 9 1.05e10
#> 8    2021 8                       CONTRATO ADMINISTRATIVO DE SE… 1.09e10 1.43e10
#> 9    2021 9                       LOCACIÓN DE SERVICIOS RELACIO… 1.24e 9 4.29e 9
#> # ℹ abbreviated name: ¹​cod_detalle_sub_generica
#> # ℹ 9 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, generica <chr>, subgenerica <chr>,
#> #   detalle_subgenerica <chr>
```

Por fin encontramos los Contratos Administrativos de Servicios. Para
comprobar si hay otro tipo de gastos incluidos, consultamos las
Específicas de este gasto. Agregamos el código del detalle de
subgenérica al código de subgenérica de la consulta anterior.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_como_se_estructura_gasto(
        generica = "5-2-3", 
        subgenerica = "2-3-2",
        detalle_subgenerica = "2-3-2-8",
        especifica = "todos"
    ) %>% 
    consultar()
#> # A tibble: 1 × 15
#>   periodo cod_especifica desc_especifica                             pia     pim
#>     <dbl> <chr>          <chr>                                     <dbl>   <dbl>
#> 1    2021 1              CONTRATO ADMINISTRATIVO DE SERVICIOS    1.09e10 1.43e10
#> # ℹ 10 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, generica <chr>, subgenerica <chr>,
#> #   detalle_subgenerica <chr>, especifica <chr>
```

Vemos que es la única específica disponible, con lo que damos por
finalizada nuestra búsqueda. Esto significa que el Estado gastó
14287679937 soles en contratos CAS el 2021. Recordemos el presupuesto
nacional de ese mismo año.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    consultar()
#> # A tibble: 1 × 10
#>   periodo total          pia          pim certificacion compromiso_anual
#>     <dbl> <chr>        <dbl>        <dbl>         <dbl>            <dbl>
#> 1    2021 TOTAL 183029770158 227932217391  212450014781     205013665381
#> # ℹ 4 more variables: atencion_de_compromiso_mensual <dbl>, devengado <dbl>,
#> #   girado <dbl>, avance_percent <dbl>
```

Ahora podemos calcular cuánto de ese monto representaron los contratos
CAS.

``` r
14287679937/227932217930 * 100
#> [1] 6.26839
```

Esto significa que el 6.27% del presupuesto del 2021 se utilizó en pagos
de obligaciones de contratos CAS.

### Elegir dónde se gasta

La función
[`elegir_donde_se_gasta()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_lugar.md)
permite obtener una división del gasto por departamento.

Con esto, podemos ver rápidamente cuánto presupuesto tuvo cada
departamento el 2021. Nótese la diferencia entre el argumento
`departamento_meta` de esta función y el argumento `departamento` de la
función
[`elegir_quien_gasta()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_institucion.md).

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_donde_se_gasta(departamento_meta = "todos") %>% 
    consultar()
#> # A tibble: 26 × 12
#>    periodo cod_departamento_meta desc_departamento_meta              pia     pim
#>      <dbl> <chr>                 <chr>                             <dbl>   <dbl>
#>  1    2021 01                    AMAZONAS                         2.31e9 3.09e 9
#>  2    2021 02                    ANCASH                           5.06e9 9.41e 9
#>  3    2021 03                    APURIMAC                         2.62e9 3.74e 9
#>  4    2021 04                    AREQUIPA                         5.16e9 8.45e 9
#>  5    2021 05                    AYACUCHO                         3.17e9 5.13e 9
#>  6    2021 06                    CAJAMARCA                        5.44e9 8.30e 9
#>  7    2021 07                    PROVINCIA CONSTITUCIONAL DEL CA… 4.40e9 5.65e 9
#>  8    2021 08                    CUSCO                            7.52e9 1.05e10
#>  9    2021 09                    HUANCAVELICA                     2.18e9 3.50e 9
#> 10    2021 10                    HUANUCO                          3.10e9 4.53e 9
#> # ℹ 16 more rows
#> # ℹ 7 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, departamento_meta <chr>
```

### Elegir cuándo se hizo el gasto

Con la función
[`elegir_cuando_se_hizo_gasto()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_tiempo.md)
se puede dividir el gasto según el trimestres o meses del periodo anual.

En caso se utilice esta función, debe tenerse en cuenta que la consulta
omitirá la información de PIA, PIM y porcentaje de avance.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_cuando_se_hizo_gasto(trimestre = "todos") %>% 
    consultar()
#> # A tibble: 4 × 12
#>   periodo cod_trimestre desc_trimestre   pia   pim certificacion
#>     <dbl> <chr>         <chr>          <dbl> <dbl>         <dbl>
#> 1    2021 1er Trimestre NA                NA    NA  134098270184
#> 2    2021 2do Trimestre NA                NA    NA   28264513674
#> 3    2021 3er Trimestre NA                NA    NA   22057623179
#> 4    2021 4to Trimestre NA                NA    NA   28029607743
#> # ℹ 6 more variables: compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, trimestre <chr>
```

Es posible escoger un trimestre específico para acotar la consulta por
meses.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_cuando_se_hizo_gasto(trimestre = "1", mes = "todos") %>% 
    consultar()
#> # A tibble: 3 × 13
#>   periodo cod_mes desc_mes   pia   pim certificacion compromiso_anual
#>     <dbl> <chr>   <chr>    <dbl> <dbl>         <dbl>            <dbl>
#> 1    2021 1       'Enero      NA    NA   94259628498      75180878682
#> 2    2021 2       'Febrero    NA    NA   20534918037      17769101752
#> 3    2021 3       'Marzo      NA    NA   19303723649      16244865287
#> # ℹ 6 more variables: atencion_de_compromiso_mensual <dbl>, devengado <dbl>,
#> #   girado <dbl>, avance_percent <dbl>, trimestre <chr>, mes <chr>
```

Si no se especifica un trimestre, se obtiene el resultado de todos los
meses.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_cuando_se_hizo_gasto(mes = "todos") %>% 
    consultar()
#> # A tibble: 12 × 12
#>    periodo cod_mes desc_mes     pia   pim certificacion compromiso_anual
#>      <dbl> <chr>   <chr>      <dbl> <dbl>         <dbl>            <dbl>
#>  1    2021 1       'Enero        NA    NA   94259628498      75180878682
#>  2    2021 2       'Febrero      NA    NA   20534918037      17769101752
#>  3    2021 3       'Marzo        NA    NA   19303723649      16244865287
#>  4    2021 4       'Abril        NA    NA   10546996795      11048670952
#>  5    2021 5       'Mayo         NA    NA    9148078844       9775084230
#>  6    2021 6       'Junio        NA    NA    8569438035       9418590739
#>  7    2021 7       'Julio        NA    NA    6329240124       8364776445
#>  8    2021 8       'Agosto       NA    NA    6097279696       7733730160
#>  9    2021 9       'Setiembre    NA    NA    9631103359      11530595013
#> 10    2021 10      'Octubre      NA    NA    7384739746       8955532246
#> 11    2021 11      'Noviembre    NA    NA    6819421440       8949753818
#> 12    2021 12      'Diciembre    NA    NA   13825446557      20042086057
#> # ℹ 5 more variables: atencion_de_compromiso_mensual <dbl>, devengado <dbl>,
#> #   girado <dbl>, avance_percent <dbl>, mes <chr>
```

## Combinar elección de parámetros

En la sección anterior se explicó el uso de cada función por separado,
pero para hacer lo mismo que se puede desde la interfaz del MEF es
necesario encadenar varias funciones. Vamos a ilustrarlo con un par de
ejemplos.

Viendo la Clasificación Programática del gasto, habíamos visto que el
Programa Presupuestal 0031 busca combatir el tráfico ilícito de drogas.
Para saber cuál fue la ejecución presupuestal de este programa por
departamento debemos encadenar un llamado a
[`elegir_en_que_se_gasta()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_destino.md)
y
[`elegir_donde_se_gasta()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_lugar.md).
Para poder reusar los datos obtenidos, se le asigna el nombre
`pp0031_departamentos` al resultado de la consulta.

``` r
pp0031_departamentos <- iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_en_que_se_gasta(categoria_presupuestal = "0031") %>% 
    elegir_donde_se_gasta(departamento_meta = "todos") %>% 
    consultar()

pp0031_departamentos
#> # A tibble: 9 × 13
#>   periodo cod_departamento_meta desc_departamento_meta                pia    pim
#>     <dbl> <chr>                 <chr>                               <dbl>  <dbl>
#> 1    2021 05                    AYACUCHO                           2.09e6 1.97e6
#> 2    2021 07                    PROVINCIA CONSTITUCIONAL DEL CALL… 8.88e5 1.20e6
#> 3    2021 10                    HUANUCO                            1.56e7 1.70e7
#> 4    2021 12                    JUNIN                              1.76e6 2.05e6
#> 5    2021 15                    LIMA                               2.25e8 2.36e8
#> 6    2021 16                    LORETO                             1.10e6 9.03e5
#> 7    2021 20                    PIURA                              7.23e5 6.64e5
#> 8    2021 21                    PUNO                               8.87e5 8.50e5
#> 9    2021 25                    UCAYALI                            1.49e7 1.49e7
#> # ℹ 8 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, categoria_presupuestal <chr>, departamento_meta <chr>
```

Hasta el momento, la Consulta Base mostrada en los diagramas
correspondió a la elección del periodo anual, al que se le podía
encadenar una de las funciones detalladas. Sin embargo, la Consulta Base
en realidad representa cualquier nivel de encadenamiento de funciones.
El último código utilizado puede representarse de la siguiente manera.

Teniendo `pp0031_departamentos`, podemos aplicarle herramientas estándar
de análisis de datos. Por ejemplo, para ordenar los departamentos de
manera descendente según su PIM usando
[dplyr](https://dplyr.tidyverse.org) usaríamos este código.

``` r
pp0031_departamentos %>% 
    dplyr::arrange(dplyr::desc(pim))
#> # A tibble: 9 × 13
#>   periodo cod_departamento_meta desc_departamento_meta                pia    pim
#>     <dbl> <chr>                 <chr>                               <dbl>  <dbl>
#> 1    2021 15                    LIMA                               2.25e8 2.36e8
#> 2    2021 10                    HUANUCO                            1.56e7 1.70e7
#> 3    2021 25                    UCAYALI                            1.49e7 1.49e7
#> 4    2021 12                    JUNIN                              1.76e6 2.05e6
#> 5    2021 05                    AYACUCHO                           2.09e6 1.97e6
#> 6    2021 07                    PROVINCIA CONSTITUCIONAL DEL CALL… 8.88e5 1.20e6
#> 7    2021 16                    LORETO                             1.10e6 9.03e5
#> 8    2021 21                    PUNO                               8.87e5 8.50e5
#> 9    2021 20                    PIURA                              7.23e5 6.64e5
#> # ℹ 8 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, categoria_presupuestal <chr>, departamento_meta <chr>
```

Vemos que Huánuco es, después de Lima, el departamento en el que se
contó con mayor presupuesto (17016801 soles). Lo siguiente que podemos
consultar es qué porción correspondió a presupuestos de viaje. Para
ello, especificamos el `departamento_meta` con el código de Huánuco y
buscamos el detalle de subgenérica “5-23.2” correspondiente a
Contratación de Servicios.

``` r
iniciar_transparencia_economica() %>% 
    elegir_periodo_anual(2021) %>% 
    elegir_en_que_se_gasta(categoria_presupuestal = "0031") %>% 
    elegir_donde_se_gasta(departamento_meta = "10") %>%
    elegir_como_se_estructura_gasto(
        generica = "5-2-3", 
        subgenerica = "2-3-2",
        detalle_subgenerica = "todos"
    ) %>% 
    consultar()
#> # A tibble: 6 × 16
#>   periodo cod_detalle_sub_generica desc_detalle_sub_generica          pia    pim
#>     <dbl> <chr>                    <chr>                            <dbl>  <dbl>
#> 1    2021 1                        VIAJES                          6.60e6 8.41e6
#> 2    2021 4                        SERVICIO DE MANTENIMIENTO, ACO… 5   e4 0     
#> 3    2021 5                        ALQUILERES DE MUEBLES E INMUEB… 4   e4 0     
#> 4    2021 6                        SERVICIOS ADMINISTRATIVOS, FIN… 3.82e6 3.82e6
#> 5    2021 7                        SERVICIOS PROFESIONALES Y TECN… 2.20e5 2.03e5
#> 6    2021 9                        LOCACIÓN DE SERVICIOS RELACION… 0      1.05e4
#> # ℹ 11 more variables: certificacion <dbl>, compromiso_anual <dbl>,
#> #   atencion_de_compromiso_mensual <dbl>, devengado <dbl>, girado <dbl>,
#> #   avance_percent <dbl>, categoria_presupuestal <chr>, generica <chr>,
#> #   subgenerica <chr>, detalle_subgenerica <chr>, departamento_meta <chr>
```

El diagrama que ilustra esta consulta es el siguiente:

Se obtuvo que el presupuesto por viajes fue de 8412586 soles.

``` r
8412586/17016801 * 100
#> [1] 49.43694
```

Finalmente, se obtiene que en el 2021, el prespuesto por viajes
representó el 49.4% del presupuesto del Programa Presupuestal en
Huánuco.

------------------------------------------------------------------------

1.  DECRETO SUPREMO Nº 068-2008-EF Artículo 3, numeral 3.4. Recuperado
    de:
    <https://www.mef.gob.pe/en/normatividad-sp-9867/por-tema/clasificadores/7377-d-s-n-068-2008-ef-2/file>

2.  Para mayor información, revisar
    <https://www.mef.gob.pe/es/?option=com_content&language=es-ES&Itemid=100959&lang=es-ES&view=article&id=454>
