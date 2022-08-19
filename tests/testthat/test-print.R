test_that("print shows and empty 'sep_df' at start", {
    df <- sep()
    expect_output(print(df), "No")
    expect_output(print(df), "No")
})
