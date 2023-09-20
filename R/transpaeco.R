transpaeco <- S7::new_class(
    name = "transpaeco", 
    parent = S7::class_data.frame,
    properties = list(
        modulo = S7::new_property(
            class = S7::class_character, 
            default = "gasto"
        ),
        actualizacion = S7::new_property(
            class = S7::class_character, 
            default = "diaria"
        ),
        req_url = S7::new_property(
            class = S7::class_character,
            getter = function(self) {
                api_gasto(
                    actualizacion = S7::prop(self, "actualizacion"),
                    modulo = S7::prop(self, "modulo")
                )
            }
        ),
        base_request = S7::new_property(
            class = S7::as_class(S7::new_S3_class("httr2_request")),
            getter = function(self) {
                S7::prop(self, "req_url") |>
                    httr2::request() |>
                    httr2::req_user_agent("perutranspaeconomica (https://perutranspaeconomica.samuelenrique.com)") |>
                    httr2::req_url_query(`_tgt` = "json", `_uhc` = "yes", cpage = 1, psize = 1000)
            }
        ),
        parametros = S7::new_property(
            class = pte_params, 
            default = pte_params()
        ),
        traduccion = S7::new_property(
            class = S7::class_list,
            getter = function(self) {
                self |> 
                    S7::prop("parametros") |> 
                    S7::props() |> 
                    purrr::flatten() |> 
                    purrr::discard(is.null)
            }
        ),
        nivel_desagregacion = S7::new_property(
            class = S7::class_integer,
            getter = function(self) {
                self |> 
                    S7::prop("traduccion") |> 
                    purrr::map_lgl(~any(.x == "todos")) |> 
                    sum()
            }
        )
    ), 
    validator = function(self) {
        
        if (!self@modulo %in% c("ingreso", "gasto")) {
            "@modulo debe ser ingreso o gasto"
        } else if (!self@actualizacion %in% c("diaria", "mensual")) {
            "@actualizacion debe ser diaria o mensual"
        } else if (self@nivel_desagregacion > 1) {
            "Debe haber solo una propiedad con valor \"todos\""
        }
    }
)

update_parameter <- S7::new_generic("update_parameter", "x")

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
    query_as_list <- S7::prop(x, "parametros") |> 
        S7::props() |> 
        purrr::flatten() |> 
        purrr::discard(is.null)
    
    query_as_list |> 
        expand.grid(stringsAsFactors = FALSE)
}

S7::method(print, transpaeco) <- function(x) {
    cli::cli_h1("Seguimiento al {x@modulo} presupuestal ({.emph actualizacion {x@actualizacion}})")
    
    cli::cli_h2("Parametros de consulta")
    
    all_params <- params_for_query()
    
    cli::cli_ul()
    
    x@traduccion |> 
        purrr::iwalk(function(value, name) {
            if(value == "todos") {
                cli::cli_li("{all_params[[name]][[\"print_name\"]]}: {.strong *{value}*}")
            } else {
                cli::cli_li("{all_params[[name]][[\"print_name\"]]}: {value}")
            }
        })
    
    cli::cli_h2("Data")
    
    if(nrow(x) == 0){
        cli::cli_alert_info("No se ha ejecutado ninguna consulta")
    } else {
        NextMethod("print", x)
    } 
    invisible(x)
}
