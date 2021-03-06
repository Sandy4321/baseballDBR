% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/battingStats.R
\name{BA}
\alias{BA}
\title{Calculate batting average}
\usage{
BA(dat = NULL)
}
\arguments{
\item{dat}{A data frame you would wish to calculate. The data frame must have the same column names found in
The \code{Lahman} package or the Chadwick Bureau GitHub repository.
For a list of column names, use the \code{Lahman_names()} function.}
}
\description{
Find batting average for batters with more than zero at bats.
Required fields from the Batting table are; "AB", and "H."
}
\examples{
\dontrun{
get_bbdb("Batting")
Batting$BA <- BA(Batting)

}

}
\keyword{BA}
\keyword{ball}
\keyword{base}
\keyword{bb}
\keyword{on}
\keyword{percentage}
