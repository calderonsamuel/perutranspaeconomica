#' Obtener la tabla de ejecucion de gasto
#'
#' @param response Un objeto de clase "xml_node" retornado por retrieve_html_body()
#'
#' @return Un tibble
#' @noRd
retrieve_response_tbl <- function(response){
    tbl_ids <- list(data = ".Data", header = ".MapTable", history = ".History")
    
    header_table <- response %>% 
        rvest::html_element(tbl_ids[["header"]]) %>%
        rvest::html_table() 
        
    column_names <- header_table %>%
        janitor::row_to_names(nrow(header_table)) %>%
        janitor::clean_names() %>%
        names() %>%
        suppressWarnings()

    response %>% 
        rvest::html_element(tbl_ids[["data"]]) %>%
        rvest::html_table(convert = FALSE) %>% 
        stats::setNames(column_names)
}
