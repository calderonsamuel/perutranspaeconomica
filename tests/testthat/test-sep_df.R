test_that("sep() returns 'sep_df'", {
    df <- sep()
  expect_s3_class(df, "sep_df")
  expect_s3_class(df, "tbl_df")
  expect_s3_class(df, "data.frame")
})

test_that("sep() starts with empty query", {
    df <- sep()
    expect_length(get_query(df) |> purrr::flatten(), 0)
})
