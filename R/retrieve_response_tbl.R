#' Obtener la tabla de ejecucion de gasto
#'
#' @param response Un objeto de clase "xml_node" retornado por retrieve_html_body()
#'
#' @return Un tibble
#'
retrive_response_tbl <- function(response){
    column_names <- retrieve_html_tbl(response, "header") |>
        janitor::row_to_names(2) |>
        janitor::clean_names() |>
        names() |>
        suppressWarnings()

    retrieve_html_tbl(response, "data") |>
        stats::setNames(column_names) |>
        dplyr::mutate(dplyr::across(.fns = as.character))
}

retrieve_html_tbl <- function(response, target = "data") {
    id <- match.arg(target, c("data", "header", "history"))
    id <- if (target == "data") ".Data" else if (target == "header")".MapTable" else ".History"

    response |>
        rvest::html_element(id) |>
        rvest::html_table()
}

resp_get_history <- function(response) {
    # Por alguna razon retorna una tabla vacía
    response |>
        retrieve_html_tbl("history")
}

