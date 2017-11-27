# Write test using "testthat"
library("testthat")

source('code/functions.R')
context('testing functions.R file')

a <- c(1, 4, 7, NA, 10)
b <- c(10, 10, 8.5, 4, 7, 9) 
c <- c(1, 2, 3, 44, NA, 3)
d <- c(5, 5, 5, 3, 5, 79, 88)

test_that('testing remove_missing()', {
  expect_equal(remove_missing(a), c(1, 4, 7, 10))
  expect_equal(remove_missing(b), c(10, 10, 8.5, 4, 7, 9))
  expect_equal(remove_missing(c), c(1, 2, 3, 44, 3))
  expect_equal(remove_missing(d), c(5, 5, 5, 3, 5, 79, 88))
})

test_that('testing get_minimum()', {
  expect_equal(get_minimum(a), 1)
  expect_equal(get_minimum('stat133'), 'non-numeric argument')
  expect_equal(get_minimum(b), 4)
  expect_equal(get_minimum(d), 3)
})

test_that('testing get_maximum()', {
  expect_equal(get_maximum(a), 10)
  expect_equal(get_maximum('stat133'), 'non-numeric argument')
  expect_equal(get_maximum(b), 10)
  expect_equal(get_maximum(d), 88)
})

test_that('testing get_range()',{
  expect_equal(get_range(a), 9)
  expect_equal(get_range('stat133'), 'non-numeric argument')
  expect_equal(get_range(b, na.rm = FALSE), 6)
  expect_equal(get_range(c), 43)
})

test_that('testing get_percentile10()', {
  expect_equal(get_percentile10(a), 1.9)
  expect_equal(get_percentile10(b, na.rm = FALSE), 5.5)
  expect_equal(get_percentile10('stat133'), 'non-numeric argument')
  expect_equal(get_percentile10(d), 4.2)
})

test_that('testing get_percentile90()', {
  expect_equal(get_percentile90(a), 9.1)
  expect_equal(get_percentile90(b), 10)
  expect_equal(get_percentile90('stat133'), 'non-numeric argument')
  expect_error(get_percentile90(c, na.rm = FALSE))
})

test_that('testing get_median()', {
  expect_equal(get_median(a), 5.5)
  expect_equal(get_median(b), 8.75)
  expect_equal(get_median('stat133'), 'non-numeric argument')
  expect_equal(get_median(c, na.rm = FALSE), NA)
})

test_that('testing get_average()', {
  expect_equal(get_average(a), 5.5)
  expect_equal(get_average(b), 8.08)
  expect_equal(get_average('stat133'), 'non-numeric argument')
  expect_equal(get_average(c, na.rm = FALSE), as.double(NA))
})

test_that('testing get_stdev()', {
  expect_equal(get_stdev(a), 3.87)
  expect_equal(get_stdev(b), 2.29)
  expect_equal(get_stdev('stat133'), 'non-numeric argument')
  expect_equal(get_stdev(c, na.rm = FALSE), 4.19)
})

test_that('testing get_quartile1()', {
  expect_equal(get_quartile1(a), 3.25)
  expect_equal(get_quartile1(b), 7.38)
  expect_equal(get_quartile1('stat133'), 'non-numeric argumemnt')
  expect_error(get_quartile1(c, na.rm = FALSE))
})

test_that('testing get_quartile3()', {
  expect_equal(get_quartile3(a), 7.75)
  expect_equal(get_quartile3(b), 9.74)
  expect_equal(get_quartile3('stat133'), 'non-numeric argumemnt')
  expect_error(get_quartile3(c, na.rm = FALSE))
})

test_that('testing count_missing()', {
  expect_equal(count_missing(a), 1)
  expect_equal(count_missing(b), 0)
  expect_equal(count_missing(c), 1)
  expect_equal(count_missing(d), 0)
})

test_that('testing rescale100()', {
  expect_equal(rescale100(a, xmin = 0, xmax = 10), c(10, 40, 70, NA, 100))
  expect_equal(rescale100(b, xmin = 0, xmax = 20), c(50, 50, 42.5, 20, 35, 45))
  expect_equal(rescale100(c, xmin = 0, xmax = 50), c(2, 4, 6, 88, NA, 6))
  expect_equal(rescale100(d, xmin = 0, xmax = 100), c(5, 5, 5, 3, 5, 79, 88))
})

test_that('testing drop_lowest()', {
  expect_equal(drop_lowest(a), c(4, 7, NA, 10))
  expect_equal(drop_lowest(b), c(10, 10, 8.5, 7, 9))
  expect_equal(drop_lowest(c), c(2, 3, 44, NA, 3))
  expect_equal(drop_lowest(d), c(5, 5, 5, 5, 79, 88))
})

test_that('testing score_homework()', {
  expect_equal(score_homework(a, drop = TRUE), 7)
  expect_equal(score_homework(b, drop = FALSE), 8.08)
  expect_equal(score_homework(c, drop = TRUE), 13)
  expect_equal(score_homework(d, drop = FALSE), 27.1)
})

test_that('testing score_quiz()', {
  expect_equal(score_quiz(a, drop = TRUE), 7)
  expect_equal(score_quiz(b, drop = FALSE), 8.08)
  expect_equal(score_quiz(c, drop = TRUE), 13)
  expect_equal(score_quiz(d, drop = FALSE), 27.1)
})

test_that('testing score_lab()', {
  expect_equal(score_lab(7), 20)
  expect_equal(score_lab(8), 40)
  expect_equal(score_lab(11), 100)
  expect_equal(score_lab(1), 0)
})