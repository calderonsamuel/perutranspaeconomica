# perutranspaeconomica (development version)

## Breaking

- Se ha creado la clase `transpaeco()` como reemplazo de `sep_df`. Esta nueva clase está basada en `S7`, usa los mismos métodos definidos previamente, y permitirá soporte para consultas del módulo de ingresos. `sep_df` llevaba ese nombre porque solo permitía hacer **S**eguimiento a la **E**jecución **P**resupuestal (gasto).
- En línea con dicho cambio, la función que inicia el flujo de consulta pasa a llamarse `iniciar_transparencia_economica()` en lugar de `seguimiento_ep()`.
- Se requerirá usar `elegir_periodo_anual()` obligatoriamente antes de cualquier otro parámetro. De esta manera se recibe feedback al instante y no solo al momento de ejecutar la consulta.
- `elegir_periodo_anual()` ya no tiene valores por defecto y requerirá que se le especifice un vector numérico de años. Anteriormente tomaba como referencia el año en curso, pero esto podría generar problemas al re-ejecutar código escrito previamente, especialmente en los primeros meses del año.

# perutranspaeconomica 0.3.1

- Cambios para evitar warnings de dplyr v1.1.0

# perutranspaeconomica 0.3.0

- Se corrigió un bug en la impresión de la metadata de consulta para el parámetro.
- Se mejoró muchísimo la documentación de la funcionalidad existente. Consultar `vignette("elegir-parametros", package = "perutranspaeconomica")`
- Se añade un sitio web para referencia

# perutranspaeconomica 0.2.0

## 'sep_df'

- Se creó la clase 'sep_df' como subclase de 'tibble::tbl_df'. 
- Los objetos 'sep_df' cuentan con un método `print.sep_df()` que muestra los parámetros de consulta mientras se van armando.

## Testing

- El paquete ha incorporado una estructura de testing en el que todas sus funciones exportadas inician o devuelven un objeto de clase 'sep_df'.
- El paquete cuenta con R CMD check automático, para mayor robustez.

## Iniciar, elegir y consultar.

- Para hacer consultas es necesario combinar las funciones `seguimiento_ep()`, alguna o varias del grupo `elegir_*()` y `consultar()`.
- Todos los parámetros indicados con funciones `elegir_*()` aceptan vectores con longitud mayor a 1. De esta manera se pueden hacer múltiples consultas a la vez.
- Todos los parámetros indicados con funciones `elegir_*()` pueden aceptar el string `'todos'`. De hecho, cualquier consulta requiere que al menos un parámetro esté indicado como `'todos'`.

## Gestión del repositorio

- A partir de la versión 0.2.0, `main` pasa a ser la versión estable, por compatibilidad con la infraestructura de r-universe. La versión en desarrollo será trabajada en `devel`, que será el branch que recibirá pull requests.
- El paquete deja de ser considerado experimental y pasa a ser estable. El README reflejará ese cambio.

# perutranspaeconomica 0.1.0

- Se puede usar `gasto()` para hacer consultas sobre la ejecución presupuestal con actualización diaria o mensual.
- Se puede *pipear* `make_gasto_query()` y `perform_gasto_query()` para usar `gasto()` aprovechando el autocompletado.


# perutranspaeconomica 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.
