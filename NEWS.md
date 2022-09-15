# perutranspaeconomica (development version)

# perutranspaeconomica 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.

# Version 0.1.0

- Se puede usar `gasto()` para hacer consultas sobre la ejecución presupuestal con actualización diaria o mensual.
- Se puede *pipear* `make_gasto_query()` y `perform_gasto_query()` para usar `gasto()` aprovechando el autocompletado.

# Version 0.2.0

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
