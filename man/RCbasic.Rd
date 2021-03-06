% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/battingStats.R
\name{RCbasic}
\alias{RCbasic}
\title{Calculate Runs Created using the basic formula.}
\usage{
RCbasic(dat = NULL)
}
\arguments{
\item{dat}{A data frame you would wish to calculate. The data frame must have the same column names found in
The \code{Lahman} package or the Chadwick Bureau GitHub repository.
For a list of column names, use the \code{Lahman_names()} function.}
}
\description{
Find the runs created using the basic formula presented by Bill James in the late 1970s.
Required fields from the batting table are "AB", "H", "BB", "X2B", "X3B", and "HR."
}
\examples{
\dontrun{
get_bbdb("Batting")
Batting$RCbasic <- RCbasic(Batting)

}

}
\keyword{RCbasic}
\keyword{base}
\keyword{extra}
\keyword{hit}
\keyword{per}
