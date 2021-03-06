% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pitchingStats.R
\name{HR_9}
\alias{HR_9}
\title{Calculate Home Runs per Nine innings}
\usage{
HR_9(dat = NULL)
}
\arguments{
\item{dat}{A data frame you would wish to calculate. The data frame must have the same column names found in
The \code{Lahman} package or the Chadwick Bureau GitHub repository.
For a list of column names, use the \code{Lahman_names()} function.}
}
\description{
Find the number of home runs a pitcher allows per nine innings pitched.
Required fields from the Pitching table are; "H" and "IPouts."
}
\examples{
\dontrun{
get_bbdb("Pitching")
Pitching$HR_9 <- HR_9(Pitching)

}

}
\keyword{hits}
\keyword{innings}
\keyword{nine}
\keyword{per}
