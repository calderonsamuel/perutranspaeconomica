current_year <- function() {
    year_chr <- Sys.Date() |>
        as.character()

    gsub(pattern = "(^.{4}).+", replacement = "\\1", x = year_chr) |>
        as.integer()
}
