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

##' Revparse
##'
##' Find object specified by revision.
##' @rdname revparse_single-methods
##' @docType methods
##' @param repo The repository
##' @param revision The revision string, see
##' http://git-scm.com/docs/git-rev-parse.html#_specifying_revisions
##' @return a \code{git_commit} or \code{git_tag} or \code{git_tree}
##' object
##' @keywords methods
##' @include S4_classes.r
##' @examples
##' \dontrun{
##' ## Create a directory in tempdir
##' path <- tempfile(pattern="git2r-")
##' dir.create(path)
##'
##' ## Initialize a repository
##' repo <- init(path)
##' config(repo, user.name="Alice", user.email="alice@@example.org")
##'
##' ## Create a file, add and commit
##' writeLines("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do",
##'            con = file.path(path, "test.txt"))
##' add(repo, "test.txt")
##' commit(repo, "First commit message")
##'
##' # Change file and commit
##' writeLines(c("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do",
##'              "eiusmod tempor incididunt ut labore et dolore magna aliqua."),
##'              con = file.path(path, "test.txt"))
##' add(repo, "test.txt")
##' commit(repo, "Second commit message")
##'
##' revparse_single(repo, "HEAD^")
##' }
setGeneric("revparse_single",
           signature = c("repo", "revision"),
           function(repo, revision)
           standardGeneric("revparse_single")
)

##' @rdname revparse_single-methods
##' @export
setMethod("revparse_single",
          signature(repo = "git_repository", revision = "character"),
          function(repo, revision)
          {
              .Call(git2r_revparse_single, repo, revision)
          }
)
