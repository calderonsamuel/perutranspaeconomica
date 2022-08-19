#' @inheritParams choose_donde_se_gasta
set_donde_se_gasta <- function(departamento_meta = NULL) {
    list(
        departamento_meta = departamento_meta
    ) |>
        purrr::discard(is.null)
}
