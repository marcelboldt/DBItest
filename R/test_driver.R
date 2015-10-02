#' \code{test_driver()} tests the "Driver" class.
#'
#' @rdname test
#' @include test_getting_started.R
#' @export
test_driver <- function(skip = NULL, ctx = get_default_context()) {
  test_suite <- "Driver"

  tests <- list(
    # Driver inherits from "DBIDriver" class
    inherits_from_driver = function() {
      expect_is(ctx$drv, "DBIDriver")
    },

    # SQL Data types exist for all basic R data types. dbDataType() does not
    # throw an error and returns a nonempty atomic character
    data_type = function() {
      expect_driver_data_type_is_character <- function(value) {
        eval(bquote({
          expect_is(dbDataType(ctx$drv, .(value)), "character")
          expect_equal(length(dbDataType(ctx$drv, .(value))), 1L)
          expect_match(dbDataType(ctx$drv, .(value)), ".")
        }))
      }

      expect_driver_has_data_type <- function(value) {
        eval(bquote(
          expect_success(expect_driver_data_type_is_character(.(value)))))
      }

      # Q: Should the "raw" type be matched to BLOB?
      expect_driver_has_data_type(logical(1))
      expect_driver_has_data_type(integer(1))
      expect_driver_has_data_type(numeric(1))
      expect_driver_has_data_type(character(1))
      expect_driver_has_data_type(list(1))
      expect_driver_has_data_type(Sys.Date())
      expect_driver_has_data_type(Sys.time())
    },

    # package name starts with R;
    # package exports constructor function, named like the package without the
    #   leading R, that has no arguments
    constructor_strict = function() {
      pkg_name <- package_name(ctx)

      expect_match(pkg_name, "^R")
      constructor_name <- gsub("^R", "", pkg_name)

      pkg_env <- getNamespace(pkg_name)
      namespace_exports <- getNamespaceExports(pkg_env)
      eval(bquote(
        expect_true(.(constructor_name) %in% namespace_exports)))
      eval(bquote(
        expect_true(exists(.(constructor_name), mode = "function", pkg_env))))
      constructor <- get(constructor_name, mode = "function", pkg_env)
      expect_that(constructor, arglist_is_empty())
    },

    # package exports constructor function, named like the package without the
    #   leading R (if it exists), where all arguments have default values
    constructor = function() {
      pkg_name <- package_name(ctx)

      constructor_name <- gsub("^R", "", pkg_name)

      pkg_env <- getNamespace(pkg_name)
      namespace_exports <- getNamespaceExports(pkg_env)
      eval(bquote(
        expect_true(.(constructor_name) %in% namespace_exports)))
      eval(bquote(
        expect_true(exists(.(constructor_name), mode = "function", pkg_env))))
      constructor <- get(constructor_name, mode = "function", pkg_env)
      expect_that(constructor, all_args_have_default_values())
    },

    # show method for driver class is defined
    show = function() {
      expect_that(ctx$drv, has_method("show"))
    },

    NULL
  )
  run_tests(tests, skip, test_suite)
}