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

#' Number of files in git_diff object
#'
#' @docType methods
#' @param x The git_diff \code{object}
#' @return a non-negative integer
#' @keywords methods
#' @export
setMethod("length",
          signature(x = "git_diff"),
          function(x)
          {
              length(x@files)
          }
)

##' Show a diff
##'
##' @aliases show,git_diff-methods
##' @docType methods
##' @param object The diff \code{object}.
##' @keywords methods
##' @export
##' @examples
##' \dontrun{
##' ## Initialize a repository
##' path <- tempfile(pattern="git2r-")
##' dir.create(path)
##' repo <- init(path)
##'
##' ## Config user
##' config(repo, user.name="Alice", user.email="alice@@example.org")
##'
##' ## Create a file, add, commit
##' writeLines("Hello world!", file.path(path, "test.txt"))
##' add(repo, "test.txt")
##' commit(repo, "Commit message")
##'
##' ## Change the file
##' writeLines(c("Hello again!", "Here is a second line", "And a third"),
##'            file.path(path, "test.txt"))
##'
##' ## Brief summary of diff between index and workdir
##' diff(repo)
##' }
setMethod("show",
          signature(object = "git_diff"),
          function(object)
          {
              cat("Old:  ")
              if (is.character(object@old)) {
                  cat(object@old, "\n")
              } else if (is(object@old, "git_tree")) {
                  show(object@old)
              } else {
                  cat("\n")
                  show(object@old)
              }
              cat("New:  ")
              if (is.character(object@new)) {
                  cat(object@new, "\n")
              } else if (is(object@new, "git_tree")) {
                  show(object@new)
              } else {
                  cat("\n")
                  show(object@new)
              }
          }
)

lines_per_file <- function(diff) {
    lapply(diff@files, function(x) {
        del <- add <- 0
        for (h in x@hunks) {
            for (l in h@lines) {
                if (l@origin == 45) {
                    del <- del + l@num_lines
                } else if (l@origin == 43) {
                    add <- add + l@num_lines
                }
            }
        }
        list(file=x@new_file, del=del, add=add)
    })
}

print_lines_per_file <- function(diff) {
  lpf <- lines_per_file(diff)
  files <- sapply(lpf, function(x) x$file)
  del <- sapply(lpf, function(x) x$del)
  add <- sapply(lpf, function(x) x$add)
  paste0(format(files), " | ", "-", format(del), " +", format(add))
}

hunks_per_file <- function(diff) {
    sapply(diff@files, function(x) length(x@hunks))
}

##' Show the summary of a diff
##'
##' @aliases summary,git_diff-methods
##' @docType methods
##' @param object The diff \code{object}.
##' @param ... Additional arguments affecting the summary produced.
##' @return None (invisible 'NULL').
##' @keywords methods
##' @export
##' @examples
##' \dontrun{
##' ## Initialize a repository
##' path <- tempfile(pattern="git2r-")
##' dir.create(path)
##' repo <- init(path)
##'
##' ## Config user
##' config(repo, user.name="Alice", user.email="alice@@example.org")
##'
##' ## Create a file, add, commit
##' writeLines("Hello world!", file.path(path, "test.txt"))
##' add(repo, "test.txt")
##' commit(repo, "Commit message")
##'
##' ## Change the file
##' writeLines(c("Hello again!", "Here is a second line", "And a third"),
##'            file.path(path, "test.txt"))
##'
##' ## diff between index and workdir
##' diff_1 <- diff(repo)
##' summary(diff_1)
##'
##' ## Diff between index and HEAD is empty
##' diff_2 <- diff(repo, index=TRUE)
##' summary(diff_2)
##'
##' ## Diff between tree and working dir, same as diff_1
##' diff_3 <- diff(tree(commits(repo)[[1]]))
##' summary(diff_3)
##'
##' ## Add changes, diff between index and HEAD is the same as diff_1
##' add(repo, "test.txt")
##' diff_4 <- diff(repo, index=TRUE)
##' summary(diff_4)
##'
##' ## Diff between tree and index
##' diff_5 <- diff(tree(commits(repo)[[1]]), index=TRUE)
##' summary(diff_5)
##'
##' ## Diff between two trees
##' commit(repo, "Second commit")
##' tree_1 <- tree(commits(repo)[[2]])
##' tree_2 <- tree(commits(repo)[[1]])
##' diff_6 <- diff(tree_1, tree_2)
##' summary(diff_6)
##'
##' ## Binary files
##' set.seed(42)
##' writeBin(as.raw((sample(0:255, 1000, replace=TRUE))),
##'          con=file.path(path, "test.bin"))
##' add(repo, "test.bin")
##' diff_7 <- diff(repo, index=TRUE)
##' summary(diff_7)
##' }
setMethod("summary",
          signature(object = "git_diff"),
          function(object, ...)
          {
              show(object)
              if (length(object) > 0) {
                  plpf <- print_lines_per_file(object)
                  hpf <- hunks_per_file(object)
                  hunk_txt <- ifelse(hpf > 1, " hunks",
                                     ifelse(hpf > 0, " hunk",
                                            " hunk (binary file)"))
                  phpf <- paste0("  in ", format(hpf), hunk_txt)
                  cat("Summary:", paste0(plpf, phpf), sep="\n")
              } else {
                  cat("No changes.\n")
              }
          }
)

#' Changes between commits, trees, working tree, etc.
#'
#' @rdname diff-methods
#' @export
#' @docType methods
#' @param x A \code{git_repository} object or the old
#' \code{git_tree} object to compare to.
#' @param index \describe{
#'   \item{\emph{When object equals a git_repository}}{
#'     Whether to compare the index to HEAD. If FALSE (the default),
#'     then the working tree is compared to the index.
#'   }
#'   \item{\emph{When object equals a git_tree}}{
#'     Whether to use the working directory (by default), or the index
#'     (if set to TRUE) in the comparison to \code{object}.
#'   }
#' }
#' @param as_char logical: should the result be converted to a
#' character string?. Default is FALSE.
#' @param filename If as_char is TRUE, then the diff can be written to
#' a file with name filename (the file is overwritten if it
#' exists). Default is NULL.
#' @param ... Additional arguments affecting the diff produced
#' @return A \code{\linkS4class{git_diff}} object if as_char is
#' FALSE. If as_char is TRUE and filename is NULL, a character string,
#' else NULL.
#' @keywords methods
#' @examples
#' \dontrun{
#' ## Initialize a repository
#' path <- tempfile(pattern="git2r-")
#' dir.create(path)
#' repo <- init(path)
#'
#' ## Config user
#' config(repo, user.name="Alice", user.email="alice@@example.org")
#'
#' ## Create a file, add, commit
#' writeLines("Hello world!", file.path(path, "test.txt"))
#' add(repo, "test.txt")
#' commit(repo, "Commit message")
#'
#' ## Change the file
#' writeLines(c("Hello again!", "Here is a second line", "And a third"),
#'            file.path(path, "test.txt"))
#'
#' ## diff between index and workdir
#' diff_1 <- diff(repo)
#' summary(diff_1)
#' cat(diff(repo, as_char=TRUE))
#'
#' ## Diff between index and HEAD is empty
#' diff_2 <- diff(repo, index=TRUE)
#' summary(diff_2)
#' cat(diff(repo, index=TRUE, as_char=TRUE))
#'
#' ## Diff between tree and working dir, same as diff_1
#' diff_3 <- diff(tree(commits(repo)[[1]]))
#' summary(diff_3)
#' cat(diff(tree(commits(repo)[[1]]), as_char=TRUE))
#'
#' ## Add changes, diff between index and HEAD is the same as diff_1
#' add(repo, "test.txt")
#' diff_4 <- diff(repo, index=TRUE)
#' summary(diff_4)
#' cat(diff(repo, index=TRUE, as_char=TRUE))
#'
#' ## Diff between tree and index
#' diff_5 <- diff(tree(commits(repo)[[1]]), index=TRUE)
#' summary(diff_5)
#' cat(diff(tree(commits(repo)[[1]]), index=TRUE, as_char=TRUE))
#'
#' ## Diff between two trees
#' commit(repo, "Second commit")
#' tree_1 <- tree(commits(repo)[[2]])
#' tree_2 <- tree(commits(repo)[[1]])
#' diff_6 <- diff(tree_1, tree_2)
#' summary(diff_6)
#' cat(diff(tree_1, tree_2, as_char=TRUE))
#'
#' ## Binary files
#' set.seed(42)
#' writeBin(as.raw((sample(0:255, 1000, replace=TRUE))),
#'          con=file.path(path, "test.bin"))
#' add(repo, "test.bin")
#' diff_7 <- diff(repo, index=TRUE)
#' summary(diff_7)
#' cat(diff(repo, index=TRUE, as_char=TRUE))
#' }
setMethod("diff",
          signature(x = "git_repository"),
          function(x,
                   index    = FALSE,
                   as_char  = FALSE,
                   filename = NULL,
                   ...)
          {
              if (as_char) {
                  ## Make sure filename is character(0) to write to a
                  ## character vector or a character vector with path in
                  ## order to write to a file.
                  filename <- as.character(filename)
                  if (any(identical(filename, NA_character_),
                          identical(nchar(filename), 0L))) {
                      filename <- character(0)
                  } else if (length(filename)) {
                      filename <- normalizePath(filename, mustWork = FALSE)
                  }
              } else {
                  ## Make sure filename is NULL
                  filename <- NULL
              }

              .Call(git2r_diff, x, NULL, NULL, index, filename)
          }
)

#' @rdname diff-methods
#' @param new_tree The new git_tree object to compare, or NULL.
#'        If NULL, then we use the working directory or the index (see
#'        the \code{index} argument).
#' @export
setMethod("diff",
          signature(x = "git_tree"),
          function(x,
                   new_tree = NULL,
                   index    = FALSE,
                   as_char  = FALSE,
                   filename = NULL,
                   ...)
          {
              if (as_char) {
                  ## Make sure filename is character(0) to write to a
                  ## character vector or a character vector with path in
                  ## order to write to a file.
                  filename <- as.character(filename)
                  if (any(identical(filename, NA_character_),
                          identical(nchar(filename), 0L))) {
                      filename <- character(0)
                  } else if (length(filename)) {
                      filename <- normalizePath(filename, mustWork = FALSE)
                  }
              } else {
                  ## Make sure filename is NULL
                  filename <- NULL
              }

              if (!is.null(new_tree)) {
                  if (! is(new_tree, "git_tree")) {
                      stop("Not a git tree")
                  }
                  if (x@repo@path != new_tree@repo@path) {
                      stop("Cannot compare trees in different repositories")
                  }
              }

              .Call(git2r_diff, NULL, x, new_tree, index, filename)
          }
)
