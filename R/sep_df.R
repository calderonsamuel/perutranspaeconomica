# constructor
#' @noRd
new_sep_df <- function(x = tibble::tibble(),
                       query = list(),
                       modulo = "gasto",
                       actualizacion = "diaria"
                       ) {

    class(x) <- c("sep_df", class(x))
    attr(x, "modulo") <- modulo
    attr(x, "actualizacion") <-  actualizacion
    attr(x, "query") <-  query
    attr(x, "req_url") <-  set_req_url_query(actualizacion)
    x
}


# helper
#' @noRd
sep_df <- function(query = list(), modulo = "gasto", actualizacion = "diaria") {

    new_sep_df(query = query,
               modulo = modulo,
               actualizacion = actualizacion)
}



# exposed API
#' @export
sep <- function(..., actualizacion = "diaria") {
    query <- list(...)
    sep_df(query = query, actualizacion = actualizacion)
}




#' @noRd
query_is_empty <- function(x) {
    query <- get_query(x)
    length(query) == 0
}

# sep_df()

# sep(year = 2020)

sep_params <- list(
    "y" = "years",
    "1" = "nivel",
    "2" = "sector",
    "3" = "pliego",
    "4" = "unidad_ejecutora",
    "5" = "departamento",
    "6" = "provincia",
    "7" = "municipalidad",
    "37" = "goblocal_o_manc",
    "36" = "mancomunidad",
    "24" = "generica",
    "25" = "subgenerica",
    "26" = "detalle_subgenerica",
    "27" = "especifica",
    "28" = "detalle_especifica",
    "14" = "fuente_financiamiento",
    "15" = "rubro",
    "17" = "tipo_de_recurso",
    "21" = "departamento_meta",
    "30" = "categoria_presupuestal",
    "31" = "producto",
    "32" = "actividad",
    "13" = "meta",
    "8" = "funcion",
    "33" = "division_funcional",
    "34" = "grupo_funcional"
)

sep_params_translate <- function(params_list) {
    sep_params |>
        purrr::keep(~.x %in% names(params_list)) |>
        purrr::map(~params_list[[.x]])
}


