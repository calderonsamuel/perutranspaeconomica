transpaeco <- S7::new_class(
    name = "transpaeco",
    properties = list(
        modulo = S7::new_property(
            class = S7::class_character, 
            default = "gasto"
        ),
        actualizacion = S7::new_property(
            class = S7::class_character, 
            default = "diaria"
        ),
        parametros = S7::new_property(
            class = pte_params, 
            default = pte_params()
        ),
        traduccion = S7::new_property(
            class = S7::class_list,
            getter = function(self) {
                self@parametros |> 
                    props() |> 
                    purrr::flatten() |> 
                    purrr::discard(is.null)
            }
        )
    ), 
    validator = function(self) {
        propiedades_de_desagregacion <- purrr::map_lgl(self@traduccion, ~any(.x == "todos")) |> sum()
        
        if (!self@modulo %in% c("ingreso", "gasto")) {
            "@modulo debe ser ingreso o gasto"
        } else if (!self@actualizacion %in% c("diaria", "mensual")) {
            "@actualizacion debe ser diaria o mensual"
        } else if (propiedades_de_desagregacion > 1) {
            "No puede haber más de una propiedad con valor \"todos\""
        }
    }
)

update_parameter <- S7::new_generic("set_param", "x")

S7::method(update_parameter, transpaeco) <- function(x, param, update_list) {
    params_list <- S7::prop(x, "parametros")
    
    update_list <- purrr::discard(update_list, is.null)
    
    if (rlang::is_empty(update_list)) {
        cli::cli_abort("Todos los argumentos de {.strong {param}} son {.code NULL}")
    }
    
    purrr::iwalk(update_list, function(value, name) {
        params_list <<- update_single_prop(params_list, param, name, value)
    })
    
    S7::prop(x, "parametros") <- params_list
    
    x
}

create_query_grid <- S7::new_generic("create_query_grid", "x")

S7::method(create_query_grid, transpaeco) <- function(x) {
    query_as_list <- prop(x, "parametros") |> 
        props() |> 
        purrr::flatten() |> 
        purrr::discard(is.null)
    
    query_as_list |> 
        expand.grid(stringsAsFactors = FALSE)
}
