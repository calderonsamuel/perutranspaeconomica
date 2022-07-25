#' Obtener el cuerpo de la respuesta HTML
#'
#' Esta operación toma la "httr2_request" definida, la realiza en el servidor remoto
#' y obtiene solo el cuerpo de la respuesta HTML. Ha sido definido así porque
#' sirve como paso intermedio para la obtención de la tabla.
#'
#' @param request Objeto de clase "httr2_request"
#'
#' @return Objeto de clase "html_node"
#'
retrieve_html_body <- function(request) {
    request |>
        httr2::req_perform() |>
        httr2::resp_body_html() |>
        rvest::html_element("body")
}
