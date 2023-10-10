#' Elegir periodo anual de consulta
#'
#' @inheritParams consultar
#' @param periodo numeric. Periodo anual de consulta
#' @inherit iniciar_transparencia_economica return
#' @export
#' @examples
#' iniciar_transparencia_economica() %>%
#'     elegir_periodo_anual(2022)
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
