#' @importFrom rlang .data
separate_cod_desc <- function(.dat, .num_col = 1L) {
    col_name <- names(.dat[, .num_col])
    if (col_name == "na_2") return(.dat %>% dplyr::rename(total = .data$na_2))
    cod_col <- glue::glue("cod_{col_name}")
    desc_col <- glue::glue("desc_{col_name}")

    .dat %>%
        tidyr::separate(col = .num_col, into = c(cod_col, desc_col), sep = ": ", extra = "merge")
}
