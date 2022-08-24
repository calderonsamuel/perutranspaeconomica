#' @noRd
expand_query <- function(x) UseMethod("expand_query")

#' @export
expand_query.sep_df <- function(x) {
    query <- get_query(x) |> purrr::flatten()
    check_years(query$years)
    # translated <- sep_params_translate(query)
    # expanded <- do.call(tidyr::expand_grid, translated)
    expanded <- do.call(tidyr::expand_grid, query)
    expanded |>
        rev() # reverse order of columns
}
