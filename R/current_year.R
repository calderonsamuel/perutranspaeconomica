current_year <- function() {
    Sys.Date() |>
        as.character() |>
        gsub(pattern = "(^.{4}).+", replacement = "\\1", x = _) |>
        as.integer()
}
