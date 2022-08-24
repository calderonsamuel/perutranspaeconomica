test_that("consultar() falla si no se especifica año de búsqueda", {
    df <- seguimiento_ep()
    expect_error(df |> consultar() |> suppressMessages())

})

test_that("consultar() devuelve un objeto 'sep_df'", {
    df <- seguimiento_ep() |> elegir_years()
    expect_s3_class(df |> consultar() |> suppressMessages(), "sep_df")
})

test_that("consultar() sirve para todos los elementos de query()", {
    df <- seguimiento_ep() |> elegir_years()
    expect_s3_class(df |> elegir_quien_gasta(nivel = "todos") |> consultar() |> suppressMessages(), "sep_df")
    expect_s3_class(df |> elegir_como_se_estructura(generica = "todos") |> consultar() |> suppressMessages(), "sep_df")
    expect_s3_class(df |> elegir_con_que_se_financia(fuente_financiamiento = "todos") |> consultar() |> suppressMessages(), "sep_df")
    expect_s3_class(df |> elegir_cuando_se_hizo_gasto(trimestre = "todos") |> consultar() |> suppressMessages(), "sep_df")
    expect_s3_class(df |> elegir_en_que_se_gasta(categoria_presupuestal = "todos") |> consultar() |> suppressMessages(), "sep_df")
    expect_s3_class(df |> elegir_donde_se_gasta(departamento_meta = "todos") |> consultar() |> suppressMessages(), "sep_df")
})
