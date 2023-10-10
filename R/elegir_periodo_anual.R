#' Elegir periodo anual de consulta
#'
#' @inheritParams consultar
#' @param periodo numeric. Periodo anual de consulta. 
#' Actualmente solo se puede consultar a partir del 2012.
#' @inherit iniciar_transparencia_economica return
#' @export
#' @examples
#' iniciar_transparencia_economica() %>%
#'     elegir_periodo_anual(periodo = 2022)
#' 
#' iniciar_transparencia_economica() %>%
#'     elegir_periodo_anual(periodo = 2022) %>%
#'     consultar()
#' 
#' # pueden consultarse multiples periodos al mismo tiempo
#' # por ejemplo, el periodo de pandemia por Covid 19
#' iniciar_transparencia_economica() %>%
#'     elegir_periodo_anual(periodo = 2020:2022) %>%
#'     consultar()
#' 
#' # se emite mensaje de error si se intenta elegir periodos no abarcados
#' tryCatch({
#'     iniciar_transparencia_economica(modulo = "gasto") %>%
#'         elegir_periodo_anual(periodo = 2011)
#' }, error = function(e) print(e))
#' 
elegir_periodo_anual <- function(x, periodo = NULL) {
    
    if (!is.numeric(periodo)) {
        cli::cli_abort("Periodo anual debe especificarse en un vector numerico")
    }
    if(!all(periodo %in% seq(from = 2012, to = current_year()))) {
        cli::cli_abort("Periodo anual debe estar entre 2012 y {current_year()}")
    }
    
    update_parameter(x, "periodo_anual", list(periodo = periodo))
}
