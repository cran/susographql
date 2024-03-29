% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/suso_gql_transformers_string.R
\name{transformers.string}
\alias{transformers.string}
\alias{contains}
\alias{endsWith}
\alias{ncontains}
\alias{nendsWith}
\alias{nstartsWith}
\alias{startsWith}
\alias{inclu}
\alias{ninclu}
\title{Utility Functions for string operator selection}
\usage{
contains(value_set)

endsWith(value_set)

ncontains(value_set)

nendsWith(value_set)

nstartsWith(value_set)

startsWith(value_set)

inclu(value_set)

ninclu(value_set)
}
\arguments{
\item{value_set}{the parameter set for the operator}
}
\value{
a list with a single named element (operator name) to be handed over to the filter.
}
\description{
Can be used in filters ("where") for operator selection. If none is selected, operator always defaults to `eq()`. The functions bellow are
valid for the corresponding inputs ComparableInt64OperationFilterInput and ComparableNullableOfInt32OperationFilterInput.
}
\details{
Also see the \link{susoop_str} selector list, which allows you, to just select the function from
a named list.
}
\section{Functions}{
\itemize{
\item \code{contains()}: contains

\item \code{endsWith()}: ends with

\item \code{ncontains()}: not contains

\item \code{nendsWith()}: not ends with

\item \code{nstartsWith()}: not starts with

\item \code{startsWith()}: starts with

\item \code{inclu()}: in

\item \code{ninclu()}: not in

}}
\examples{

# set filter so that the string contains "area"
contains("area")

# set filter to string ending with .shp
endsWith(".shp")

}
