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

##' Create tag targeting HEAD commit in repository
##'
##' @rdname tag-methods
##' @docType methods
##' @param object The repository \code{object}.
##' @param name Name for the tag.
##' @param message The tag message.
##' @param session Add sessionInfo to tag message. Default is FALSE.
##' @param tagger The tagger (author) of the tag
##' @return invisible(\code{git_tag}) object
##' @keywords methods
##' @include commit.r
##' @examples
##' \dontrun{
##' ## Initialize a temporary repository
##' path <- tempfile(pattern="git2r-")
##' dir.create(path)
##' repo <- init(path)
##'
##' ## Create a user
##' config(repo, user.name="Alice", user.email="alice@@example.org")
##'
##' ## Commit a text file
##' writeLines("Hello world!", file.path(path, "example.txt"))
##' add(repo, "example.txt")
##' commit(repo, "First commit message")
##'
##' ## Create tag
##' tag(repo, "Tagname", "Tag message")
##'
##' ## List tags
##' tags(repo)
##' }
setGeneric("tag",
           signature = "object",
           function(object,
                    name,
                    message,
                    session = FALSE,
                    tagger  = default_signature(object))
           standardGeneric("tag"))

##' @rdname tag-methods
##' @export
setMethod("tag",
          signature(object = "git_repository"),
          function(object,
                   name,
                   message,
                   session,
                   tagger)
          {
              ## Argument checking
              stopifnot(is.character(name),
                        identical(length(name), 1L),
                        nchar(name[1]) > 0,
                        is.character(message),
                        identical(length(message), 1L),
                        nchar(message[1]) > 0,
                        is.logical(session),
                        identical(length(session), 1L),
                        is(tagger, "git_signature"))

              if (session)
                  message <- add_session_info(message)

              invisible(.Call(git2r_tag_create, object, name, message, tagger))
          }
)

##' Tags
##'
##' @rdname tags-methods
##' @docType methods
##' @param repo The repository \code{object}
##' \code{\linkS4class{git_repository}}. If the \code{repo} argument
##' is missing, the repository is searched for with
##' \code{\link{discover_repository}} in the current working
##' directory.
##' @return list of tags in repository
##' @keywords methods
##' @examples
##' \dontrun{
##' ## Initialize a temporary repository
##' path <- tempfile(pattern="git2r-")
##' dir.create(path)
##' repo <- init(path)
##'
##' ## Create a user
##' config(repo, user.name="Alice", user.email="alice@@example.org")
##'
##' ## Commit a text file
##' writeLines("Hello world!", file.path(path, "example.txt"))
##' add(repo, "example.txt")
##' commit(repo, "First commit message")
##'
##' ## Create tag
##' tag(repo, "Tagname", "Tag message")
##'
##' ## List tags
##' tags(repo)
##' }
setGeneric("tags",
           signature = "repo",
           function(repo)
           standardGeneric("tags"))

##' @rdname tags-methods
##' @export
setMethod("tags",
          signature(repo = "missing"),
          function()
          {
              callGeneric(repo = lookup_repository())
          }
)

##' @rdname tags-methods
##' @export
setMethod("tags",
          signature(repo = "git_repository"),
          function(repo)
          {
              .Call(git2r_tag_list, repo)
          }
)

##' Brief summary of a tag
##'
##' @aliases show,git_tag-methods
##' @docType methods
##' @param object The tag \code{object}
##' @return None (invisible 'NULL').
##' @keywords methods
##' @export
##' @examples
##' \dontrun{
##' ## Initialize a temporary repository
##' path <- tempfile(pattern="git2r-")
##' dir.create(path)
##' repo <- init(path)
##'
##' ## Create a user
##' config(repo, user.name="Alice", user.email="alice@@example.org")
##'
##' ## Commit a text file
##' writeLines("Hello world!", file.path(path, "example.txt"))
##' add(repo, "example.txt")
##' commit(repo, "First commit message")
##'
##' ## Create tag
##' tag(repo, "Tagname", "Tag message")
##'
##' ## View brief summary of tag
##' tags(repo)[[1]]
##' }
setMethod("show",
          signature(object = "git_tag"),
          function(object)
          {
              cat(sprintf("[%s] %s\n",
                          substr(object@target, 1 , 6),
                          object@name))
          }
)

##' Summary of a tag
##'
##' @aliases summary,git_tag-methods
##' @docType methods
##' @param object The tag \code{object}
##' @param ... Additional arguments affecting the summary produced.
##' @return None (invisible 'NULL').
##' @keywords methods
##' @export
##' @examples
##' \dontrun{
##' ## Initialize a temporary repository
##' path <- tempfile(pattern="git2r-")
##' dir.create(path)
##' repo <- init(path)
##'
##' ## Create a user
##' config(repo, user.name="Alice", user.email="alice@@example.org")
##'
##' ## Commit a text file
##' writeLines("Hello world!", file.path(path, "example.txt"))
##' add(repo, "example.txt")
##' commit(repo, "First commit message")
##'
##' ## Create tag
##' tag(repo, "Tagname", "Tag message")
##'
##' ## Summary of tag
##' summary(tags(repo)[[1]])
##' }
setMethod("summary",
          signature(object = "git_tag"),
          function(object, ...)
          {
              cat(sprintf(paste0("name:    %s\n",
                                 "target:  %s\n",
                                 "tagger:  %s <%s>\n",
                                 "when:    %s\n",
                                 "message: %s\n"),
                          object@name,
                          object@target,
                          object@tagger@name,
                          object@tagger@email,
                          as(object@tagger@when, "character"),
                          object@message))
          }
)
