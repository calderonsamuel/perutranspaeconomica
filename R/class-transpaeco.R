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
        psize = S7::new_property(
           class = S7::class_numeric,
           default = 1000
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
                S7::prop(self, "req_url") %>%
                    httr2::request() %>%
                    httr2::req_user_agent("perutranspaeconomica (https://perutranspaeconomica.samuelenrique.com)") %>%
                    httr2::req_url_query(
                        `_tgt` = "json",
                        `_uhc` = "yes",
                        cpage = 1,
                        psize = S7::prop(self, "psize")
                    )
            }
        ), 
        parametros = S7::new_property(
            class = pte_params, 
            default = pte_params()
        ),
        traduccion = S7::new_property(
            class = S7::class_list,
            getter = function(self) {
                self %>% 
                    S7::prop("parametros") %>% 
                    S7::props() %>% 
                    purrr::flatten() %>% 
                    purrr::discard(is.null)
            }
        ),
        nivel_desagregacion = S7::new_property(
            class = S7::class_integer,
            getter = function(self) {
                self %>% 
                    S7::prop("traduccion") %>% 
                    purrr::map_lgl(~any(.x == "todos")) %>% 
                    sum()
            }
        )
    ), 
    validator = function(self) {
        propiedades_de_desagregacion <- self %>% 
            S7::prop("traduccion") %>% 
            purrr::map_lgl(~any(.x == "todos")) %>% 
            sum()
        
        regex_check <- check_params_validator(self)
        
        if (!self@modulo %in% c("ingreso", "gasto")) {
            "@modulo debe ser ingreso o gasto"
        } else if (!self@actualizacion %in% c("diaria", "mensual")) {
            "@actualizacion debe ser diaria o mensual"
        } else if (propiedades_de_desagregacion > 1) {
            "Debe haber solo una propiedad con valor \"todos\""
        } else if (!regex_check$passes) {
            regex_check$message
        }
    }
)

update_parameter <- S7::new_generic("set_param", "x")

S7::method(update_parameter, transpaeco) <- function(x, param, update_list) {
    
    params_list <- S7::prop(x, "parametros")
    
    periodo_anual_is_not_set <- S7::prop(params_list, "periodo_anual") %>% 
        purrr::pluck("periodo") %>% 
        is.null()
    
    if (param != "periodo_anual" && periodo_anual_is_not_set) {
        cli::cli_abort("Se debe usar {.code elegir_periodo_anual() antes de elegir otros parametros}")
    }
    
    if (S7::prop(x, "modulo") == "ingreso" && param %in% c("destino", "lugar")) {
        cli::cli_abort("No es posible consultar {.strong {param}} para modulo de {.strong ingreso}")
    }
    
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
    query_as_list <- S7::prop(x, "parametros") %>% 
        S7::props() %>% 
        purrr::flatten() %>% 
        purrr::discard(is.null)
    
    query_as_list %>% 
        expand.grid(stringsAsFactors = FALSE)
}

S7::method(print, transpaeco) <- function(x) {
    cli::cli_h1("Seguimiento al {x@modulo} presupuestal ({.emph actualizacion {x@actualizacion}})")
    
    cli::cli_h2("Parametros de consulta")
    
    all_params <- params_for_query()
    
    cli::cli_ul()
    
    x %>%
        S7::prop("traduccion") %>% 
        purrr::iwalk(function(value, name) {
            if(length(value) == 1L && value == "todos") {
                cli::cli_li("{all_params[[name]][[\"print_name\"]]}: {.strong *{value}*}")
            } else {
                value <- glue::glue_collapse(value, sep = ", ", last = " y ")
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

# Function to check parameters validity
check_params_validator <- function(x) {
    
    # Retrieve all parameters for the query
    all_params <- params_for_query()
    
    # Extract 'traduccion' and 'modulo' from the input 'x'
    traduccion <- S7::prop(x, "traduccion")
    modulo <- S7::prop(x, "modulo")
    
    # Create an iterator for parameter checks
    check_iterator <- rlang::list2(
        item_name = names(traduccion) %>% stringr::str_remove(glue::glue("_{modulo}$")),
        item_value = unname(traduccion),
        item_regex = purrr::map(names(traduccion), ~all_params[[.x]][["regex"]]),
        item_options = purrr::map(names(traduccion), ~all_params[[.x]][["options"]])
    )
    
    # Check parameters and create a message for invalid parameters
    message <- check_iterator %>%
        purrr::pmap(function(item_name, item_value, item_regex, item_options) {
            
            if (!is.null(item_regex)) {
                # Check if the item values match the expected regex
                matches_regex <- all(stringr::str_detect(item_value, item_regex))
                
                # Generate an error message if the item value doesn't match the regex and is not "todos"
                if (!matches_regex && !(item_value == "todos")) {
                    message <- glue::glue("En modulo {modulo}, `{item_name}` debe hacer match con expresion regular '{item_regex}'")
                    return(message)
                }
            }
            
            if (!is.null(item_options)) {
                matches_options <- all(item_value %in% item_options)
                if (!matches_options && !(item_value == "todos")) {
                    message <- glue::glue(
                        "En modulo {modulo}, `{item_name}` debe ser uno de {options}", 
                        options = glue::glue_collapse(item_options, sep = ", ")
                    )
                    
                    message <- glue::glue("({message})")
                    return(message)
                } 
            }
            return(NULL)
        }) %>%
        purrr::compact() %>%
        # purrr::imap_chr(function(value, position) glue::glue("{position}) {value}")) %>%
        purrr::map_chr(~.x) %>%
        glue::glue_collapse(sep = "\n- ")
    
    # Return a list indicating if all parameters passed and the message
    list(
        passes = nchar(message) == 0,
        message = message
    )
}

