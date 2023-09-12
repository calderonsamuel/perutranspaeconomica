#' Definir el query URL de la consulta
#'
#' @inheritParams api_gasto
#'
#' @return Objeto con clase "httr2_request"
#'
set_req_url_query <- function(actualizacion = "diaria", modulo = "gasto") {

    base_url <- api_gasto(actualizacion = actualizacion, modulo = modulo) |>
        httr2::request() |>
        httr2::req_user_agent("perutranspaeconomica (https://perutranspaeconomica.samuelenrique.com)") |>
        httr2::req_url_query(`_tgt` = "json", `_uhc` = "yes", cpage = 1, psize = 1000)

    base_url
}
