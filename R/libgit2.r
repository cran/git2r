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

##' Compile time options for libgit2.
##'
##' @return A list with threads, https and ssh set to TRUE/FALSE.
##' @keywords methods
##' @export
##' @examples
##' \dontrun{
##' libgit2_features()
##' }
##'
libgit2_features <- function() {
    .Call(git2r_libgit2_features)
}

##' Version of the libgit2 library being currently used
##'
##' @return A list with major, minor and rev
##' @keywords methods
##' @export
##' @examples
##' \dontrun{
##' libgit2_version()
##' }
##'
libgit2_version <- function() {
    .Call(git2r_libgit2_version)
}
