#' Definir el query URL de la consulta
#'
#' @param actualizacion chr. Uno de c("mensual", "diaria")
#'
#' @return Objeto con clase "httr2_request"
#'
set_req_url_query <- function(actualizacion = "diaria") {

    base_url <- api_gasto(actualizacion = actualizacion) |>
        httr2::request() |>
        httr2::req_user_agent("perutranspaeconomica (https://perutranspaeconomica.samuelenrique.com)") |>
        httr2::req_url_query(`_tgt` = "json", `_uhc` = "yes", cpage = 1, psize = 1000)

    base_url
}
