test_that("seguimiento_ep() returns 'sep_df'", {
    df <- seguimiento_ep()
  expect_s3_class(df, "sep_df")
  expect_s3_class(df, "tbl_df")
  expect_s3_class(df, "data.frame")
})

test_that("seguimiento_ep() starts with empty query", {
    df <- seguimiento_ep()
    expect_length(get_query(df) |> purrr::flatten(), 0)
})
