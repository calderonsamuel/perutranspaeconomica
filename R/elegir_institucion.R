#' Elegir la institucion que utiliza el presupuesto
#'
#' Estas funciones permiten desglosar la busqueda haciendo uso del clasificador institucional. 
#' `elegir_quien_gasta()` y `elegir_quien_recauda()` sirven los módulos de gasto e ingresos, respectivamente.
#' `elegir_institucion()` es una versión agnóstica que sirve para ámbos módulos.
#' 
#' Estas funciones aplicarán una validación de  la forma para cada argumento 
#' mediante expresiones regulares. Sumado a ello, se aplica una validación 
#' para evitar valores anómalos.
#' 
#' @inheritParams consultar
#' @param nivel chr. Nivel de gobierno. Puede ser "E" (gobierno nacional),
#' "M" (gobiernos locales) o "R" (gobiernos regionales). Si es "E" o "R",
#' le corresponde `sector`. Si es "M", le corresponde `goblocal_o_manc`.
#' @param sector chr. Codigo de sector, de forma "00" (2 digitos).
#' @param pliego chr. Código de pliego, de forma "000" (3 digitos).
#' @param unidad_ejecutora chr. Código de Unidad Ejecutora. 
#' No tiene forma estandar, puede tener entre uno (1) y seis (6) digitos.
#' @param goblocal_o_manc chr. Escoger entre "M" (gobierno local)
#' o "N" (mancomunidad). Si es "M", puede desglosarse por `departamento`, `provincia` y `municipalidad`.
#' Si es "N", le corresponde `mancomunidad`.
#' @param mancomunidad chr. Código de mancomunidad, de forma "000000" (6 digitos).
#' @param departamento chr. Código de departamento, de forma "00" (2 digitos). 
#' El valor "07" corresponde a Callao.
#' @param provincia chr. Código de provincia, de forma "00" (2 digitos). 
#' El valor "01" corresponde a capital de departamento.
#' @param municipalidad chr. Código de municipalidad, de forma "000000" (6 digitos). 
#' **No es lo mismo que el ubigeo**. Los dos primeros digitos deben ser "30".
#'
#' @rdname elegir_institucion
#' @inherit iniciar_transparencia_economica return
#' @export
#' 
#' @examples
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_quien_gasta(nivel = "todos")
#' 
#' # informacion de todas las UEs del Ministerio de Educacion
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_quien_gasta(
#'         nivel = "E", 
#'         sector = "10",
#'         pliego = "010",
#'         unidad_ejecutora = "todos"
#'     ) %>%
#'     consultar()
#' 
#' # informacion de todas las provincias de Amazonas.
#' # notese que devuelve codigos de provincia de 4 digitos.
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_quien_gasta(
#'         nivel = "M", 
#'         goblocal_o_manc = "M",
#'         departamento = "01",
#'         provincia = "todos"
#'     ) %>%
#'     consultar()
#' 
#' # para desglosar por provincia, deben usarse solo dos digitos.
#' # por ejemplo, para ver los municipios de la provincia de Bagua
#' # debe usarse "02"
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_quien_gasta(
#'         nivel = "M", 
#'         goblocal_o_manc = "M",
#'         departamento = "01",
#'         provincia = "02",
#'         municipalidad = "todos"
#'     ) %>%
#'     consultar()
#' 
#' # cuando no se respeta la forma, el mensaje de error
#' # muestra la expresion regular esperada
#' tryCatch({
#'     iniciar_transparencia_economica(modulo = "gasto") %>%
#'         elegir_periodo_anual(2022) %>%
#'         elegir_quien_gasta(
#'             nivel = "M", 
#'             goblocal_o_manc = "M",
#'             departamento = "01",
#'             provincia = "0102",
#'             municipalidad = "todos"
#'         )
#' }, error = function(e) print(e))
#' 
elegir_institucion <- function(x, 
                               nivel = NULL,
                               sector = NULL,
                               pliego = NULL,
                               unidad_ejecutora = NULL,
                               goblocal_o_manc = NULL,
                               mancomunidad = NULL,
                               departamento = NULL,
                               provincia = NULL,
                               municipalidad = NULL) {
    
    update_list <- list(
        nivel = nivel,
        sector = sector,
        pliego = pliego,
        unidad_ejecutora = unidad_ejecutora,
        goblocal_o_manc = goblocal_o_manc,
        mancomunidad = mancomunidad,
        departamento = departamento,
        provincia = provincia,
        municipalidad = municipalidad
    )
    
    names(update_list) <- names(update_list) %>%
        paste0("_", S7::prop(x, "modulo"))
    
    update_parameter(
        x = x, 
        param = "institucion",
        update_list =  update_list
    )
}

#' @rdname elegir_institucion
#' @export
elegir_quien_gasta <- function(x,
                               nivel = NULL,
                               sector = NULL,
                               pliego = NULL,
                               unidad_ejecutora = NULL,
                               goblocal_o_manc = NULL,
                               mancomunidad = NULL,
                               departamento = NULL,
                               provincia = NULL,
                               municipalidad = NULL) {
    
    modulo <- S7::prop(x, "modulo")
    
    if (modulo == "ingreso") {
        cli::cli_abort(
            "Para consultas del modulo de {.strong {modulo}} usa 
            {.code elegir_quien_recauda()} o {.code elegir_institucion()}"
        )
    }
    
    elegir_institucion(
        x = x,
        nivel = nivel,
        sector = sector,
        pliego = pliego,
        unidad_ejecutora = unidad_ejecutora,
        goblocal_o_manc = goblocal_o_manc,
        mancomunidad = mancomunidad,
        departamento = departamento,
        provincia = provincia,
        municipalidad = municipalidad
    )
}

#' @rdname elegir_institucion
#' @export
elegir_quien_recauda <- function(x,
                               nivel = NULL,
                               sector = NULL,
                               pliego = NULL,
                               unidad_ejecutora = NULL,
                               goblocal_o_manc = NULL,
                               mancomunidad = NULL,
                               departamento = NULL,
                               provincia = NULL,
                               municipalidad = NULL) {
    
    modulo <- S7::prop(x, "modulo")
    
    if (modulo == "gasto") {
        cli::cli_abort(
            "Para consultas del modulo de {.strong {modulo}} usa 
            {.code elegir_quien_gasta()} o {.code elegir_institucion()}"
        )
    }
    
    elegir_institucion(
        x = x,
        nivel = nivel,
        sector = sector,
        pliego = pliego,
        unidad_ejecutora = unidad_ejecutora,
        goblocal_o_manc = goblocal_o_manc,
        mancomunidad = mancomunidad,
        departamento = departamento,
        provincia = provincia,
        municipalidad = municipalidad
    )
}
