## git2r, R bindings to the libgit2 library.
## Copyright (C) 2013-2016 The git2r contributors
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

##' Fetch new data and update tips
##'
##' @rdname fetch-methods
##' @docType methods
##' @param repo the repository
##' @param name the remote's name
##' @param credentials The credentials for remote repository
##'     access. Default is NULL. To use and query an ssh-agent for the
##'     ssh key credentials, let this parameter be NULL (the default).
##' @param verbose Print information each time a reference is updated
##'     locally. Default is \code{TRUE}.
##' @param refspec The refs to fetch and which local refs to update,
##'     see examples. Pass NULL to use the
##'     \code{remote.<repository>.fetch} variable. Default is
##'     \code{NULL}.
##' @return invisible \code{\linkS4class{git_transfer_progress}}
##'     object
##' @keywords methods
##' @include S4_classes.r
##' @examples
##' \dontrun{
##' ## Initialize three temporary repositories
##' path_bare <- tempfile(pattern="git2r-")
##' path_repo_1 <- tempfile(pattern="git2r-")
##' path_repo_2 <- tempfile(pattern="git2r-")
##'
##' dir.create(path_bare)
##' dir.create(path_repo_1)
##' dir.create(path_repo_2)
##'
##' bare_repo <- init(path_bare, bare = TRUE)
##' repo_1 <- clone(path_bare, path_repo_1)
##' repo_2 <- clone(path_bare, path_repo_2)
##'
##' config(repo_1, user.name="Alice", user.email="alice@@example.org")
##' config(repo_2, user.name="Bob", user.email="bob@@example.org")
##'
##' ## Add changes to repo 1
##' writeLines("Lorem ipsum dolor sit amet",
##'            con = file.path(path_repo_1, "example.txt"))
##' add(repo_1, "example.txt")
##' commit(repo_1, "Commit message")
##'
##' ## Push changes from repo 1 to origin (bare_repo)
##' push(repo_1, "origin", "refs/heads/master")
##'
##' ## Fetch changes from origin (bare_repo) to repo 2
##' fetch(repo_2, "origin")
##'
##' ## List updated heads
##' fetch_heads(repo_2)
##'
##' ## Checking out GitHub pull requests locally
##' path <- tempfile(pattern="ghit-")
##' repo <- clone("https://github.com/leeper/ghit", path)
##' fetch(repo, "origin", refspec = "pull/13/head:refs/heads/BRANCHNAME")
##' checkout(repo, "BRANCHNAME")
##' summary(repo)
##' }
setGeneric("fetch",
           signature = "repo",
           function(repo,
                    name,
                    credentials = NULL,
                    verbose     = TRUE,
                    refspec     = NULL)
           standardGeneric("fetch"))

##' @rdname fetch-methods
##' @export
setMethod("fetch",
          signature(repo = "git_repository"),
          function(repo, name, credentials, verbose, refspec)
          {
              result <- .Call(
                  git2r_remote_fetch,
                  repo,
                  name,
                  credentials,
                  "fetch",
                  verbose,
                  refspec)

              invisible(result)
          }
)

##' Get updated heads during the last fetch.
##'
##' @rdname fetch_heads-methods
##' @docType methods
##' @param repo the repository
##' @return list with the S4 class \code{\linkS4class{git_fetch_head}}
##' entries. NULL if there is no FETCH_HEAD file.
##' @keywords methods
##' @include S4_classes.r
##' @examples
##' \dontrun{
##' ## Initialize three temporary repositories
##' path_bare <- tempfile(pattern="git2r-")
##' path_repo_1 <- tempfile(pattern="git2r-")
##' path_repo_2 <- tempfile(pattern="git2r-")
##'
##' dir.create(path_bare)
##' dir.create(path_repo_1)
##' dir.create(path_repo_2)
##'
##' bare_repo <- init(path_bare, bare = TRUE)
##' repo_1 <- clone(path_bare, path_repo_1)
##' repo_2 <- clone(path_bare, path_repo_2)
##'
##' config(repo_1, user.name="Alice", user.email="alice@@example.org")
##' config(repo_2, user.name="Bob", user.email="bob@@example.org")
##'
##' ## Add changes to repo 1
##' writeLines("Lorem ipsum dolor sit amet",
##'            con = file.path(path_repo_1, "example.txt"))
##' add(repo_1, "example.txt")
##' commit(repo_1, "Commit message")
##'
##' ## Push changes from repo 1 to origin (bare_repo)
##' push(repo_1, "origin", "refs/heads/master")
##'
##' ## Fetch changes from origin (bare_repo) to repo 2
##' fetch(repo_2, "origin")
##'
##' ## List updated heads
##' fetch_heads(repo_2)
##' }
setGeneric("fetch_heads",
           signature = "repo",
           function(repo)
           standardGeneric("fetch_heads"))

##' @rdname fetch_heads-methods
##' @export
setMethod("fetch_heads",
          signature(repo = "git_repository"),
          function(repo)
          {
              .Call(git2r_repository_fetch_heads, repo)
          }
)
