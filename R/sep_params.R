sep_params <- function() {
    list(
        "y" = "periodo",
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
        "34" = "grupo_funcional",
        "22" = "trimestre",
        "23" = "mes"
    )
}

sep_params_translate <- function(params_list) {
    sep_params() |>
        purrr::keep(~.x %in% names(params_list)) |>
        purrr::map(~params_list[[.x]]) |>
        purrr::map(~ifelse(.x == "todos", "", .x))
}
