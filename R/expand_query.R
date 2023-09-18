#' @noRd
expand_query <- function(x) UseMethod("expand_query")

#' @export
expand_query.sep_df <- function(x) {
    query <- get_query(x) |> purrr::flatten()
    check_years(query$periodo)
    expanded <- expand.grid(query, stringsAsFactors = FALSE)
    
    expanded |>
        rev() # reverse order of columns
}
