## git2r, R bindings to the libgit2 library.
## Copyright (C) 2013-2015 The git2r contributors
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License, version 2,
## as published by the Free Software Foundation.
##
## git2r is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License along
## with this program; if not, write to the Free Software Foundation, Inc.,
## 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

##' Punch card
##'
##' @rdname punch_card-methods
##' @docType methods
##' @param repo The repository
##' @param main Default title for the plot is "Punch card on repo:"
##' and repository workdir basename. Supply a new title if you desire
##' one.
##' @param ... Additional arguments affecting the plot
##' @return invisible NULL
##' @keywords methods
##' @include S4_classes.r
##' @importFrom graphics axis
##' @importFrom graphics par
##' @importFrom graphics plot.new
##' @importFrom graphics plot.window
##' @importFrom graphics symbols
##' @export
##' @examples
##' \dontrun{
##' ## Initialize repository
##' path <- tempfile(pattern="git2r-")
##' dir.create(path)
##' repo <- clone("https://github.com/ropensci/git2r.git", path)
##'
##' ## Plot
##' punch_card(repo)
##' }
setGeneric("punch_card",
           signature = "repo",
           function(repo, main = NULL, ...)
           standardGeneric("punch_card"))

##' @rdname punch_card-methods
##' @export
setMethod("punch_card",
          signature(repo = "git_repository"),
          function(repo, main, ...)
          {
              savepar <- graphics::par(las = 1, mar = c(2.2, 6, 2, 0))
              on.exit(par(savepar))

              wd <- c("Saturday", "Friday", "Thursday", "Wednesday",
                      "Tuesday", "Monday", "Sunday")

              ## Extract information from repository
              df <- as(repo, "data.frame")
              df$when <- as.POSIXlt(df$when)
              df$hour <- df$when$hour
              df$weekday <- df$when$wday

              ## Create a key and tabulate
              df$key <- paste0(df$weekday, "-", df$hour)
              df <- as.data.frame(table(df$key), stringsAsFactors = FALSE)
              names(df) <- c("key", "Commits")

              ## Convert key to Weekday and Hour
              df$Weekday <- sapply(strsplit(df$key, "-"), "[", 1)
              df$Weekday <- factor(df$Weekday,
                                   levels = c(6, 5, 4, 3, 2, 1, 0),
                                   labels = wd)
              df$Hour <- as.integer(sapply(strsplit(df$key, "-"), "[", 2))
              df$key <- paste0(df$Weekday, "-", df$Hour)

              ## Scale
              df$Commits <- sqrt((df$Commits / max(df$Commits)) / pi)

              graphics::plot.new()
              graphics::plot.window(xlim = c(0, 23), ylim = c(0.8, 7.2))
              graphics::symbols(df$Hour, df$Weekday, circles = df$Commits,
                                xaxt = "n", yaxt = "n", inches = FALSE,
                                fg = "white", bg = "black", add = TRUE, ...)
              h <- 0:23
              h <- paste0(ifelse(h > 9, as.character(h),
                                 paste0("0", as.character(h))), ":00")
              graphics::axis(1, at = 0:23, labels = h)
              graphics::axis(2, at = 1:7, labels = wd)

              if (is.null(main)) {
                  if (is_bare(repo)) {
                      main <- "Punch card"
                  } else {
                      main <- sprintf("Punch card on repository: %s",
                                      basename(workdir(repo)))
                  }
              }

              graphics::title(main)

              invisible(NULL)
          }
)
