test_that("check_years() works inside elegir_periodo_anual()", {
    df <- seguimiento_ep()
    expect_error(df |> elegir_periodo_anual(2011))
    expect_error(df |> elegir_periodo_anual(list(2022)))
    expect_error(df |> elegir_periodo_anual(current_year() + 1))
})

test_that("elegir_periodo_anual() returns expected objects", {
    df <- seguimiento_ep() |> elegir_periodo_anual()
    expect_s3_class(df, "sep_df")
    expect_type(get_query(df)$periodo, type = "list")
    expect_type(get_query(df)$periodo[[1]], type = "integer")
})

test_that("periodos anuales distintos dan diferentes PIA", {
    df1 <- seguimiento_ep() |> elegir_periodo_anual(2020) |> consultar() |> suppressMessages()
    df2 <- seguimiento_ep() |> elegir_periodo_anual(2021) |> consultar() |> suppressMessages()

    expect_false(identical(df1$pia, df2$pia))
})

test_that("Se pueden consultar varios periodos al mismo tiempo", {
    seguimiento_ep() %>%
        elegir_periodo_anual(2019:2021) %>%
        consultar() %>%
        suppressMessages() %>%
        expect_s3_class(class = c("sep_df", "tbl"))
})
