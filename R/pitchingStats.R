
#' @title Calculate walks per nine innings
#' @description Find batting average walks per nine innings for pitchers with more one or more inning pitched.
#' Required fields from the Pitching table are; "IPouts", and "BB."
#' @param dat A data frame you would wish to calculate. The data frame must have the same column names found in
#' The \code{Lahman} package or the Chadwick Bureau GitHub repository.
#' For a list of column names, use the \code{Lahman_names()} function.
#' @keywords BB BB_9 BB9 bb/9
#' @export BB_9
#' @examples
#' \dontrun{
#' get_bbdb("Pitching")
#' Pitching$BB_9 <- BB_9(Pitching)
#'
#' }
#'
BB_9 <- function (dat=NULL){
    ifelse(is.null(dat), message("Please supply a valid data frame."), dat <- dat)

    if (!all(c("BB", "IPouts") %in% names(dat))){
        message("Not enough data to calculate. Please make sure your data inclueds 'BB', and 'IPouts'")
    }

    ifelse(dat$IPouts > 2,
               BB_9 <- round((dat$BB*9 / (dat$IPouts / 3)), 3), NA)
    return(BB_9)
}

#' @title Fielding Independent Pitching (FIP)
#' @description Find the FIP for all pitchers with one or strike outs in a particular season.
#' Required fields from the Pitching table are "BB", "HBP", "SO", and "IPouts."
#' @param dat A data frame you would wish to calculate. The data frame must have the same column names found in
#' The \code{Lahman} package or the Chadwick Bureau GitHub repository.
#' For a list of column names, use the \code{Lahman_names()} function.
#' @param Sep.Leagues If TRUE the algorithum will calculate different run enviornments for the National and American leagues. Grouping
#' the leauges can solve problems introduced by the designated hitter and hitting pitchers. It also serves to further isolate for
#' park factors between the American and National leauges. The default for this argument is FALSE.
#' @param NA_to_zero If TRUE this will replace NAs with 0 for years that certain stats weren't counted. For example, sacrafice hits
#' weren't a counted statistic until 1954, therefore we are technically unable to calculate wOBA for any player prior to 1954.
#' The default is set to TRUE. Even though this is bad practice mathematically, many in the sabermetrics community accept the practice.
#' If FALSE, the wOBA calculation will return NaN for years with missing data.
#' @param Fangraphs If TRUE the function will download wOBA values from Fangraphs. If FALSE the function will use the internal
#' formula adapted from Tom Tango's original wOBA formula. Note, the internal formula is typically identical to Fangraphs and
#' does not require an external download. If not specified, the default is set to FALSE.
#' @keywords FIP fielding independent pitching
#' @export FIP
#' @examples
#' \dontrun{
#' get_bbdb("Pitching")
#' Pitching$FIP <- FIP(Pitching, Fangraphs=FALSE, NA_to_zero=TRUE, Sep.Leagues=FALSE)
#'
#' }
#'
FIP <- function (dat=NULL, Fangraphs=FALSE, NA_to_zero=TRUE, Sep.Leagues=FALSE){
    ifelse(is.null(dat), message("Please supply a valid data frame."), dat <- dat)

    if (!all(c("BB", "HBP", "SO", "IPouts") %in% names(dat))){
        message("Not enough data to calculate. Please make sure your data inclueds 'BB', 'HBP', 'K', and 'IPouts'")
    }

    if(isTRUE(Sep.Leagues) & isTRUE(Fangraphs)){
        print("The Fangraphs Guts table does not sperate FIP by league. Applying the default calculation...")
        Fangraphs=FALSE
    }

    fip <- fip_values(dat=dat, Fangraphs=Fangraphs, Sep.Leagues=Sep.Leagues)

    if (isTRUE(NA_to_zero)){
            dat <- dplyr::mutate(dat, HBP=ifelse(is.na(HBP),0,HBP))
        }

    if(isTRUE(Sep.Leagues)){
            fip <- fip[, c("yearID", "lgID", "cFIP")]
            dat <- dplyr::left_join(dat, fip, by=c("yearID", "lgID"))
        } else {
            fip <- fip[, c("yearID", "cFIP")]
            dat <- dplyr::left_join(dat, fip, by="yearID")
        }

        ifelse(dat$SO > 0,
               fip <- (((dat$HR*13) + ((dat$BB + dat$IBB + dat$HBP - dat$IBB)*3) - (dat$SO*2)) / (dat$IPouts/3) + dat$cFIP), NA)

    return(fip)
}


#' @title Calculate Hits per Nine innings
#' @description Find the number of hits a pitcher throws per nine innings pitched.
#' Required fields from the Pitching table are; "H", "BB", and "IPouts."
#' @param dat A data frame you would wish to calculate.  The data frame must have the same column names found in
#' The \code{Lahman} package or the Chadwick Bureau GitHub repository.
#' For a list of column names, use the \code{Lahman_names()} function.
#' @keywords hits per nine innings
#' @export H_9
#' @examples
#' \dontrun{
#' get_bbdb("Pitching")
#' Pitching$H_9 <- H_9(Pitching)
#'
#' }
#'
H_9 <- function (dat=NULL){
    ifelse(is.null(dat), message("Please supply a valid data frame."), dat <- dat)

    if (!all(c("H", "BB", "IPouts") %in% names(dat))){
        message("Not enough data to calculate. Please make sure your data inclueds 'H', and 'IPouts'")
    }

    ifelse(dat$IPouts > 2,
               H_9 <- round((dat$H*9) / (dat$IPouts/3), 3), NA)

    return(H_9)
}

#' @title Calculate Home Runs per Nine innings
#' @description Find the number of home runs a pitcher allows per nine innings pitched.
#' Required fields from the Pitching table are; "H" and "IPouts."
#' @param dat A data frame you would wish to calculate. The data frame must have the same column names found in
#' The \code{Lahman} package or the Chadwick Bureau GitHub repository.
#' For a list of column names, use the \code{Lahman_names()} function.
#' @keywords hits per nine innings
#' @export HR_9
#' @examples
#' \dontrun{
#' get_bbdb("Pitching")
#' Pitching$HR_9 <- HR_9(Pitching)
#'
#' }
#'
HR_9 <- function (dat=NULL){
    ifelse(is.null(dat), message("Please supply a valid data frame."), dat <- dat)

    if (!all(c("Hr", "IPouts") %in% names(dat))){
        message("Not enough data to calculate. Please make sure your data inclueds 'Hr', and 'IPouts'")
    }

    ifelse(dat$IPouts > 2, HR_9 <- round((dat$HR*9) / (dat$IPouts/3), 3), NA)
    return(HR_9)
}

#' @title Calculate the innings pitched
#' @description Find the number of innings a player has ptiched for a season.
#' Required fields from the Pitching table are; "IPouts."
#' @param dat A data frame you would wish to calculate. The data frame must have the same column names found in
#' The \code{Lahman} package or the Chadwick Bureau GitHub repository.
#' For a list of column names, use the \code{Lahman_names()} function.
#' @keywords innings pitched
#' @export IP
#' @examples
#' \dontrun{
#' get_bbdb("Pitching")
#' Pitching$IP <- IP(Pitching)
#'
#' }
#'
IP <- function (dat=NULL){
    ifelse(is.null(dat), message("Please supply a valid data frame."), dat <- dat)

    if (!all(c("IPouts") %in% names(dat))){
        message("Not enough data to calculate. Please make sure your data inclueds 'IPouts'")
    }

    ifelse(dat$IPouts > 2, IP <- round(dat$IPouts/3, 3), NA)
    return(IP)
}

#' @title Calculate Strikes per Nine innings
#' @description Find the number of strikes a pitcher throws per nine innings pitched.
#' Required fields from the Pitching table are; "H", "BB", "IPouts", and "SO."
#' @param dat A data frame you would wish to calculate. The data frame must have the same column names found in
#' The \code{Lahman} package or the Chadwick Bureau GitHub repository.
#' For a list of column names, use the \code{Lahman_names()} function.
#' @keywords strikes per nine innings
#' @export K_9
#' @examples
#' \dontrun{
#' get_bbdb("Pitching")
#' Pitching$K_9 <- K_9(Pitching)
#'
#' }
#'
K_9 <- function (dat=NULL){
    ifelse(is.null(dat), message("Please supply a valid data frame."), dat <- dat)

    if (!all(c("H", "BB", "IPouts", "SO") %in% names(dat))){
        message("Not enough data to calculate. Please make sure your data inclueds 'H', 'BB', 'SO', and 'IPouts'")
    }

    ifelse(dat$IPouts > 2, K_9 <- round((dat$SO*9) / (dat$IPouts/3), 3), NA)
    return(K_9)
}

#' @title Calculate the left on base percentage
#' @description Find the percentaqge of base runners that a pitcher leaves on base of the course of a season.
#' Required fields from the Pitching table are; "H", "BB", "HBP", "R", and "HR."
#' @param dat A data frame you would wish to calculate. The data frame must have the same column names found in
#' The \code{Lahman} package or the Chadwick Bureau GitHub repository.
#' For a list of column names, use the \code{Lahman_names()} function.
#' @keywords LOB_pct LOB LOB percentage
#' @export LOB_pct
#' @examples
#' \dontrun{
#' get_bbdb("Pitching")
#' Pitching$LOB_pct <- LOB_pct(pitching_df)
#'
#' }
#'
LOB_pct <- function (dat=NULL){
    ifelse(is.null(dat), message("Please supply a valid data frame."), dat <- dat)

    if (!all(c("H", "BB", "HBP", "R", "HR") %in% names(dat))){
        message("Not enough data to calculate. Please make sure your data inclueds 'AB', 'BB', 'IBB', 'HBP', 'SF', and 'SH'")
    }

    ifelse(dat$IPouts > 2, LOB_pct <- round((dat$H+dat$BB+dat$HBP-dat$R) / (dat$H+dat$BB+dat$HBP-(1.4*dat$HR)), 3), NA)

    return(LOB_pct)
}

#' @title Calculate Walks plus Hits per Innings Pitched
#' @description Find the number of walks plus hits a pitcher allows per inning pitched.
#' Required fields from the Pitching table are; "H", "BB", and "IPouts."
#' @param dat A data frame you would wish to calculate. The data frame must have the same column names found in
#' The \code{Lahman} package or the Chadwick Bureau GitHub repository.
#' For a list of column names, use the \code{Lahman_names()} function.
#' @keywords Walks plus Hits per Innings Pitched WHIP
#' @export WHIP
#' @examples
#' \dontrun{
#' get_bbdb("Pitching")
#' Pitching$WHIP <- WHIP(pitching_df)
#'
#' }
#'
WHIP <- function (dat=NULL){
    ifelse(is.null(dat), message("Please supply a valid data frame."), dat <- dat)

    if (!all(c("H", "BB", "IPouts") %in% names(dat))){
        message("Not enough data to calculate. Please make sure your data inclueds 'H', 'BB', and 'IPouts'")
    }

    ifelse(dat$IPouts > 2, WHIP <- round((dat$BB+dat$H) / (dat$IPouts/3), 3), NA)

    return(WHIP)
}




