#' @export
choose_years <- function(x, years) UseMethod("choose_years")

#' @export
choose_years.sep_df <- function(x, years = current_year()) {
    old <- get_query(x)
    attr(x, "query") <- purrr::list_modify(old, years = years)
    x
}
