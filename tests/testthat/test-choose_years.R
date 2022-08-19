test_that("check_years() works inside choose_years()", {
    df <- sep()
    expect_error(df |> choose_years(2011))
    expect_error(df |> choose_years(list(2022)))
    expect_error(df |> choose_years(current_year() + 1))
})

test_that("choose_years() returns expected objects", {
    df <- sep() |> choose_years()
    expect_s3_class(df, "sep_df")
    expect_type(get_query(df)$years, type = "list")
    expect_type(get_query(df)$years[[1]], type = "integer")
})

