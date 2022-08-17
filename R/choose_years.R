#' @export
choose_years <- function(x, years) UseMethod("choose_years")

#' @export
choose_years.sep_df <- function(x, years = current_year()) {
    check_years(years)
    query <- get_query(x)
    new_years <- list(years)
    query <- purrr::list_modify(query, years = new_years)
    attr(x, "query") <- query
    x
}
