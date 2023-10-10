#' Obtener el cuerpo de la respuesta HTML
#'
#' Esta operación toma la "httr2_response" definida y obtiene solo el cuerpo de la respuesta HTML. Ha sido definido así porque
#' sirve como paso intermedio para la obtención de la tabla.
#'
#' @param response Objeto de clase "httr2_response"
#'
#' @return Objeto de clase "html_node"
#' @noRd
retrieve_html_body <- function(response) {
    response %>%
        httr2::resp_body_html() %>%
        rvest::html_element("body")
}
