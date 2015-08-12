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

##' Bundle bare repo of package
##'
##' Clone the package git repository as a bare repository to
##' \code{pkg/inst/pkg.git}
##' @rdname bundle_r_package-methods
##' @docType methods
##' @param repo The repository with package to bundle.
##' @return Invisible bundled S4 \code{\linkS4class{git_repository}}
##' object
##' @keywords methods
##' @examples
##' \dontrun{
##' ## Initialize repository
##' path <- tempfile()
##' dir.create(path)
##' path <- file.path(path, "git2r")
##' repo <- clone("https://github.com/ropensci/git2r.git", path)
##'
##' ## Bundle bare repository in package
##' bundle_r_package(repo)
##'
##' ## Build and install bundled package
##' wd <- setwd(dirname(path))
##' system(sprintf("R CMD build %s", path))
##' pkg <- list.files(".", pattern = "[.]tar[.]gz$")
##' system(sprintf("R CMD INSTALL %s", pkg))
##' setwd(wd)
##'
##' ## Reload package
##' detach("package:git2r", unload = TRUE)
##' library(git2r)
##'
##' ## Summarize last five commits of bundled repo
##' repo <- repository(system.file("git2r.git", package = "git2r"))
##' invisible(lapply(commits(repo, n = 5), summary))
##'
##' ## Plot content of bundled repo
##' plot(repo)
##' }
setGeneric("bundle_r_package",
           signature = "repo",
           function(repo)
           standardGeneric("bundle_r_package"))

##' @rdname bundle_r_package-methods
##' @export
setMethod("bundle_r_package",
          signature(repo = "git_repository"),
          function(repo)
          {
              ## Check for 'inst' folder
              inst <- paste0(workdir(repo), "inst", sep = "")
              if (!identical(file.info(inst)$isdir, TRUE))
                  dir.create(inst)

              ## Check for 'pkg.git' folder
              local_path <- paste0(basename(workdir(repo)), ".git", sep = "")
              local_path <- file.path(inst, local_path)
              if (file.exists(local_path))
                  stop(paste0("Repo already exists:", local_path))
              invisible(clone(workdir(repo), local_path, bare = TRUE))
          }
)
