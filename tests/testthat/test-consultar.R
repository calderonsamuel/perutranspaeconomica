test_that("consultar falla si no se especifica año de búsqueda", {
    df <- sep()
    expect_error(df |> consultar())

})

test_that("consultar devuelve un objeto 'sep_df'", {
    df <- sep() |> choose_years()
    expect_s3_class(df |> consultar(), "sep_df")

})
