#' @name test_all
#' @section Tests:
#' \code{\link{test_getting_started}}:
#' Getting started with testing
NULL

#' Getting started with testing
#'
#' Tests very basic features of a DBI driver package, to support testing
#' and test-first development right from the start.
#'
#' @inheritParams test_all
#' @include test_all.R
#' @family tests
#' @export
test_getting_started <- function(skip = NULL, ctx = get_default_context()) {
  test_suite <- "Getting started"

  #' @details
  #' This function defines the following tests:
  #' \describe{
  tests <- list(
    #' \item{\code{has_context}}{
    #' \code{make_context()} must be called before calling any of the
    #' \code{test_} functions in this package}
    has_context = function() {
      expect_is(ctx, "DBItest_context")
    },

    #' \item{\code{package_dependencies}}{
    #' can relate the driver to an installed (or devtools-loaded) package;
    #' package depends (!) on "DBI" and imports "methods"}. This test requires
    #' the \code{devtools} package and will be skipped if it is not installed.
    package_dependencies = function() {
      if (!requireNamespace("devtools", quietly = TRUE)) {
        skip("devtools not installed")
      }
      expect_error(pkg_name <- package_name(ctx), NA)
      expect_is(pkg_name, "character")

      pkg_path <- find.package(pkg_name)

      pkg <- devtools::as.package(pkg_path)
      pkg_depends <- devtools::parse_deps(pkg$depends)$name
      expect_true("DBI" %in% pkg_depends)
      pkg_imports <- devtools::parse_deps(pkg$imports)$name
      expect_true("methods" %in% pkg_imports)
    },

    NULL
  )
  #'}
  run_tests(tests, skip, test_suite)
}
