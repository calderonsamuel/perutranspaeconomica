test_that("consultar() falla si no se especifica año de búsqueda", {
    df <- sep()
    expect_error(df |> consultar())

})

test_that("consultar() devuelve un objeto 'sep_df'", {
    df <- sep() |> choose_years()
    expect_s3_class(df |> consultar(), "sep_df")
})

test_that("consultar() sirve para todos los elementos de query()", {
    df <- sep() |> choose_years()
    expect_s3_class(df |> choose_quien_gasta(nivel = "todos") |> consultar(), "sep_df")
    expect_s3_class(df |> choose_como_se_estructura(generica = "todos") |> consultar(), "sep_df")
    expect_s3_class(df |> choose_con_que_se_financia(fuente_financiamiento = "todos") |> consultar(), "sep_df")
    expect_s3_class(df |> choose_cuando_se_hizo_gasto(trimestre = "todos") |> consultar(), "sep_df")
    expect_s3_class(df |> choose_en_que_se_gasta(categoria_presupuestal = "todos") |> consultar(), "sep_df")
    expect_s3_class(df |> choose_donde_se_gasta(departamento_meta = "todos") |> consultar(), "sep_df")
})
