% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/battingStats.R
\name{PA}
\alias{PA}
\title{Calculate plate appearances for batters}
\usage{
PA(dat = NULL)
}
\arguments{
\item{dat}{A data frame you would wish to calculate. The data frame must have the same column names found in
The \code{Lahman} package or the Chadwick Bureau GitHub repository.
For a list of column names, use the \code{Lahman_names()} function.}
}
\description{
Find the plate appearances (PA) for batters.
Required fields from the batting table are "AB", "BB", "HBP", "SH", and "SF."
}
\examples{
\dontrun{
get_bbdb("Batting")
Batting$PA <- PA(Batting)

}

}
\keyword{PA}
\keyword{base}
\keyword{on}
\keyword{percentage}
