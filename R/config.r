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

##' Config
##'
##' Config file management. To display the configuration variables,
##' call method \code{config} with only the \code{repo} argument.
##' @rdname config-methods
##' @docType methods
##' @param repo the \code{repo} to configure
##' @param user.name the user name. Use NULL to delete the entry
##' @param user.email the e-mail address. Use NULL to delete the entry
##' @return S3 class \code{git_config} with the configuration
##' @keywords methods
##' @include S4_classes.r
##' @examples \dontrun{
##' ## Initialize a temporary repository
##' path <- tempfile(pattern="git2r-")
##' dir.create(path)
##' repo <- init(path)
##'
##' ## Set user name and email. The configuration is returned
##' cfg <-config(repo, user.name="Alice", user.email="alice@@example.org")
##'
##' ## View configuration list
##' cfg
##'
##' ## Display configuration
##' config(repo)
##'}
setGeneric("config",
           signature = "repo",
           function(repo,
                    user.name,
                    user.email)
           standardGeneric("config"))

##' @rdname config-methods
##' @export
setMethod("config",
          signature(repo = "git_repository"),
          function(repo,
                   user.name,
                   user.email)
          {
              variables <- as.list(match.call(expand.dots = TRUE))
              variables <- variables[-(1:2)]

              if (length(variables)) {
                  ## Check that the variable is either a character vector or NULL
                  check_is_character <- sapply(variables, function(v) {
                      any(is.character(v), is.null(v))
                  })
                  check_is_character <- check_is_character[!check_is_character]
                  if (length(check_is_character)) {
                      stop(sprintf("\n%s", paste(names(check_is_character),
                                                 "must be character",
                                                 collapse="\n")))
                  }

                  .Call(git2r_config_set, repo, variables)
              }

              cfg <- .Call(git2r_config_get, repo)

              ## Sort the variables within levels by name
              structure(lapply(cfg, function(x) x[order(names(x))]),
                        class = "git_config")
          }
)

##' @export
print.git_config <- function(x, ...) {
    lapply(names(x), function(level) {
        cat(sprintf("%s:\n", level))
        lapply(names(x[[level]]), function(entry) {
            cat(sprintf("        %s=%s\n", entry, x[[level]][[entry]][1]))
        })
    })
}
