% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/battingStats.R
\name{OPS}
\alias{OPS}
\title{Calculate on base percentage plus slugging (OPS)}
\usage{
OPS(dat = NULL)
}
\arguments{
\item{dat}{A data frame you would wish to calculate. The data frame must have the same column names found in
The \code{Lahman} package or the Chadwick Bureau GitHub repository.
For a list of column names, use the \code{Lahman_names()} function.}
}
\description{
Find the OPS for batters with more than zero hits.
Required fields from the batting table are "H", "X2B", "X3B", "HR", "BB", "HBP", "AB" and "SF."
}
\examples{
\dontrun{
get_bbdb("Batting")
Batting$OPS <- OPS(Batting)

}

}
\keyword{OPS}
\keyword{base}
\keyword{on}
\keyword{percentage}
