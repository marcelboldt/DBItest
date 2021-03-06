% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/context.R
\name{make_context}
\alias{get_default_context}
\alias{make_context}
\alias{set_default_context}
\title{Test contexts}
\usage{
make_context(drv, connect_args, set_as_default = TRUE)

set_default_context(ctx)

get_default_context()
}
\arguments{
\item{drv}{\code{[DBIDriver]}\cr An expression that constructs a DBI driver,
like `SQLite()`.}

\item{connect_args}{\code{[named list]}\cr Connection arguments (names and
values).}

\item{set_as_default}{\code{[logical(1)]}\cr Should the created context be
set as default context?}

\item{ctx}{\code{[DBItest_context]}\cr A test context.}
}
\value{
\code{[DBItest_context]}\cr A test context, for
  \code{set_default_context} the previous default context (invisibly) or
  \code{NULL}.
}
\description{
Create a test context, set and query the default context.
}

