#' Obtener la tabla de ejecucion de gasto
#'
#' @param response Un objeto de clase "xml_node" retornado por retrieve_html_body()
#'
#' @return Un tibble
#'
retrieve_response_tbl <- function(response){
    tbl_ids <- list(data = ".Data", header = ".MapTable", history = ".History")
    
    column_names <- response |> 
        rvest::html_element(tbl_ids[["header"]]) |>
        rvest::html_table() |> 
        janitor::row_to_names(2) |>
        janitor::clean_names() |>
        names() |>
        suppressWarnings()

    response |> 
        rvest::html_element(tbl_ids[["data"]]) |>
        rvest::html_table(convert = FALSE) |> 
        stats::setNames(column_names)
}
