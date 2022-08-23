test_that("check_years() works inside elegir_years()", {
    df <- seguimiento_ep()
    expect_error(df |> elegir_years(2011))
    expect_error(df |> elegir_years(list(2022)))
    expect_error(df |> elegir_years(current_year() + 1))
})

test_that("elegir_years() returns expected objects", {
    df <- seguimiento_ep() |> elegir_years()
    expect_s3_class(df, "sep_df")
    expect_type(get_query(df)$years, type = "list")
    expect_type(get_query(df)$years[[1]], type = "integer")
})

