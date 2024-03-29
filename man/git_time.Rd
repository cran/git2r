% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/time.R
\name{git_time}
\alias{git_time}
\alias{as.character.git_time}
\alias{format.git_time}
\alias{as.POSIXct.git_time}
\alias{print.git_time}
\title{Time}
\usage{
\method{as.character}{git_time}(x, tz = "GMT", origin = "1970-01-01", usetz = TRUE, ...)

\method{format}{git_time}(x, tz = "GMT", origin = "1970-01-01", usetz = TRUE, ...)

\method{as.POSIXct}{git_time}(x, tz = "GMT", origin = "1970-01-01", ...)

\method{print}{git_time}(x, tz = "GMT", origin = "1970-01-01", usetz = TRUE, ...)
}
\arguments{
\item{x}{\R  object to be converted.}

\item{tz}{a character string.  The time zone specification to be used
    for the conversion, \emph{if one is required}.  System-specific (see
    \link[base]{time zones}), but \code{""} is the current time zone, and
    \code{"GMT"} is UTC (Universal Time, Coordinated).  Invalid values
    are most commonly treated as UTC, on some platforms with a warning.}

\item{origin}{a date-time object, or something which can be coerced by
    \code{as.POSIXct(tz = "GMT")} to such an object.  Optional since \R
    4.3.0, where the equivalent of \code{"1970-01-01"} is used.}

\item{usetz}{logical.  Should the time zone abbreviation be appended
    to the output?  This is used in printing times, and more reliable
    than using \code{"\%Z"}.}

\item{...}{further arguments to be passed to or from other methods.}
}
\description{
The class \code{git_time} stores the time a Git object was created.
}
\details{
The default is to use \code{tz = "GMT"} and \code{origin =
"1970-01-01"}. To use your local timezone, set \code{tz =
Sys.timezone()}.
}
\examples{
\dontrun{
## Initialize a temporary repository
path <- tempfile(pattern="git2r-")
dir.create(path)
repo <- init(path)

## Create a first user and commit a file
config(repo, user.name = "Alice", user.email = "alice@example.org")
writeLines("Hello world!", file.path(path, "example.txt"))
add(repo, "example.txt")
commit(repo, "First commit message")

## Create tag
tag(repo, "Tagname", "Tag message")

as.POSIXct(commits(repo)[[1]]$author$when)
as.POSIXct(tags(repo)[[1]]$tagger$when)
as.POSIXct(tags(repo)[[1]]$tagger$when, tz = Sys.timezone())
}
}
\seealso{
\code{\link{when}}
}
