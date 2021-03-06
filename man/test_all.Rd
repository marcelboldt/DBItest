% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/test_all.R, R/test_getting_started.R, R/test_driver.R, R/test_connection.R, R/test_result.R, R/test_sql.R, R/test_meta.R, R/test_compliance.R
\name{test_all}
\alias{test_all}
\title{Run all tests}
\usage{
test_all(skip = NULL, ctx = get_default_context())
}
\arguments{
\item{skip}{\code{[character()]}\cr A vector of regular expressions to match
against test names; skip test if matching any.}

\item{ctx}{\code{[DBItest_context]}\cr A test context as created by
\code{\link{make_context}}.}
}
\description{
This function calls all tests defined in this package (see the section
"Tests" below).
}
\section{Tests}{

This function runs the following tests:


\code{\link{test_getting_started}}:
Getting started with testing


\code{\link{test_driver}}:
Test the "Driver" class


\code{\link{test_connection}}:
Test the "Connection" class


\code{\link{test_result}}:
Test the "Result" class


\code{\link{test_sql}}:
Test SQL methods


\code{\link{test_meta}}:
Test metadata functions


\code{\link{test_compliance}}:
Test full compliance to DBI
}

