# git2r 0.36.2 (2025-03-29)

## CHANGES

* Use 'pkg-config --static --libs' in the build configuration script
  on the Darwin platform.

# git2r 0.36.1 (2025-03-28)

## CHANGES

* Updated the SystemRequirements field in the DESCRIPTION file to
  include the libgit2 dependencies libssh2 and openssl.

* Improved the error message in the build configuration script to also
  mention the library dependencies 'openssl', and 'libssh2' when the
  requirement 'libgit2 >= 1.0' could not be satisfied

# git2r 0.36.0 (2025-03-27)

## CHANGES

* Added Proxy Support. The R Functions clone, fetch, push, and
  remote_ls now include a proxy parameter, enabling users to define
  proxy settings directly within these functions, see PR #461. Thanks
  to Gregor Lichtner.

* Switch linking on Windows to use pkg-config when available. Thanks
  to Tomas Kalibera for providing the patch.

* On macOS, the build configuration script no longer downloads a
  static build of libgit2 since libgit2 is now included in the macOS
  recicpes (https://github.com/R-macos/recipes).

* Update clone function docs and params, see PR #475. Thanks to
  Alexandros Kouretsis.

# git2r 0.35.0 (2024-10-20)

## CHANGES

* The bundled libgit2 source code has been removed and libgit2 must
  now be installed on the system.

* Fix build after API change in libgit2 1.8.0.

* The system requirement for libgit2 has been updated to libgit2
  version >= 1.0.

* Add `$(C_VISIBILITY)` to compiler flags to hide internal symbols
  from shared object.

* On MacOS, if libgit2 is not found, the build configuration tries to
  download a static build of libgit2 version 1.8.1
  (https://github.com/autobrew/bundler/releases/tag/libgit2-1.8.1) and
  use that instead, after the sha256 of the downloaded
  'libgit2-1.8.1-universal.tar.xz' file has been checked.

# git2r 0.33.0 (2023-11-26)

## CHANGES

* Added a missing 'git2r-package' alias to the documentation.

* Added the argument 'raw' to the 'content' function to make it
  possible to get a blob content as a raw vector, see issue #461.

* Updated the bundled libgit2 source code to version 1.7.1.

* Changed the R dependency from >= 3.4 to >= 4.0.

* Added a missing '-liconv' to PKG_LIBS in Makevars.win.

# git2r 0.32.0 (2023-04-12)

## CHANGES

* Updated the bundled libgit2 source code to version 1.6.3.

* Fix build failure of bundled libgit2 when structure for nanosecond
  type is mssing.

# git2r 0.31.0 (2023-01-26)

## CHANGES

* Removed unused macro 'AC_PROG_CC' from the build configuration
  script.

# git2r 0.30.1 (2022-03-15)

## CHANGES

* Added the build configuration script ('src/Makevars.ucrt') for
  Windows UCRT. Thanks to Tomas Kalibera for providing the patch.

* Added documentation about line endings in the diff
  function. Different operating systems handle line endings
  differently and to avoid problems in diffs, Git can be configured to
  handle these differences in line endings

# git2r 0.29.0 (2021-11-18)

## CHANGES

* Added a 'branch' argument to the 'init' function to make it possible
  to specify the branch name.

* Updated the build configuration script on Windows and MacOS to use
  libgit2 version 1.3.0.

* Updated the bundled libgit2 source code to version 1.3.0.

* Renamed the NEWS file to NEWS.md and changed to use markdown format
  style.

# git2r 0.28.0 (2021-01-10)

## IMPROVEMENTS

* Updated to use libgit2 version 1.1.0 on Windows.

* Fix handling of a symbolic reference when checking out previous
  branch.

* Added a configure option '--without-libgit2' to ignore presence of a
  system libgit2 library and instead use the internal git2r libgit2
  library. Usage:
  R CMD INSTALL --configure-args='--without-libgit2' git2r_x.y.z.tar.gz

* Updated some tests to work with libgit2 version 1.1.0.

# git2r 0.27.1 (2020-05-03)

## CHANGES

* Fixed the CITATION file to pass 'R CMD check' without a NOTE.

# git2r 0.27.0 (2020-05-01)

## IMPROVEMENTS

* Updated the bundled libgit2 source code to version '0.28.5'.

* Updated the build configuration script to be able to build git2r
  with a system installation of libgit2 version >= 1.0.

* Updated to use libgit2 version 1.0.0 on Windows.

* The build configuration script checks for minimum required version
  of libssh2 (version >= 1.8). Issue #420.

* Updated to use roxygen2 version 7.1.0 to build the documentation.

* Make it easier to view and change the timezone (John Blischak in
  #408).

* Fixed 'ls_tree' to handle content in subfolder, see description in
  PR #402.

* The 'branch_create' function has been changed to use the
  'last_commit()' function as default to determine the commit to which
  the new branch should point.

# git2r 0.26.1 (2019-06-30)

## BUG FIXES

* Fixed the broken build on Solaris.

# git2r 0.26.0 (2019-06-29)

## IMPROVEMENTS

* Updated the bundled libgit2 source code to version '0.28.2'.

* Added the 'force' argument to the 'tag' function to overwrite an
  existing tag.

* Allow a zero length tag message.

* Make it possible to create a lighweight tag.

* Added the 'ref' argument to the 'commits' function to give a
  reference to list commits from.

* Added the utility function 'lookup_commit' to lookup a commit
  related to a git object.

* The 'path' argument was added to the 'commits' function to make it
  possible to specify that only commits modifying this file ('path')
  will be returned to reproduce 'git log' with '--no-follow', see the
  documentation. (Peter Carbonetto and John Blischak in PR #372)

## BUG FIXES

* Removed the timezone offset from the commit time to fix an incorrect
  time in GMT when reading information from a repository (Thierry
  Onkelinx in PR #393).

# git2r 0.25.2 (2019-03-20)

## CHANGES

* Improved the build configuration script: if the system installation
  of libgit2 is to old, use the bundled libgit2 instead of raising an
  error.

## BUG FIXES

* Fixed the broken build on Solaris.

# git2r 0.25.1 (2019-03-17)

## BUG FIXES

* Fixed significant warning from 'R CMD check'

# git2r 0.25.0 (2019-03-17)

## CHANGES

* Updated the bundled libgit2 source code to version '0.28.1'.

* Added additional parameters to the 'diff' function to control the
  output, see the documentation.

* Added getPass option to the password argument in 'cred_user_pass'
  (Annie Wang in PR #383)

* Changed the 'print' functions to return its argument invisibly.

* Changed the 'git_config_files' function to return a 'data.frame'

* Changed the 'ahead_behind' function to accept a tag or a branch for
  the local and upstrean commit.

* Changed the 'descendent_of' function to accept a tag or a branch for
  the 'commit' and 'ancestor' commit.

## BUG FIXES

* Fixed memory protection errors in the git2r C source code reported
  by the 'rchk' tool.

* Fixed listing of 'commits' from a shallow repository.

* Fixed the configuration script to include the missing macro
  'AM_ICONV'.

# git2r 0.24.0 (2019-01-07)

This is a bug-fix release.

## BUG FIXES

* Fixed memory protection errors in the git2r C source code reported
  by the 'rchk' tool.

* Raise an error if the path argument to the 'hashfile' function is
  NA.

# git2r 0.23.0 (2018-07-17)

## IMPROVEMENTS

* Updated the bundled libgit2 source code to v0.27.3 (504bd54).

## BREAKING CHANGE

* On macOS, git2r no longer enables SSH transport by default. This is
  due to the complexity to build the dependencies for SSH transport in
  an R package when macOS no longer ships the OpenSSL headers.
  However, you can install git2r from source on macOS (see the 'R
  Installation and Administration' manual) with SSH transport enabled
  if you first install the libgit2 library, for example, using the
  Homebrew package manager. Another possibility is to let the build
  configuration automatically download the libgit2 library from the
  Homebrew package manager with:

  install.packages('git2r', type='source', configure.vars='autobrew=yes')

# git2r 0.22.1 (2018-07-10)

## NEW FEATURES

* Added the 'git_config_files' method to locate configuration files.

* Added the 'stash_pop' method to apply a single stashed state from
  the stash list and remove it from the list if successful.

* Added the 'stash_apply' method to apply a single stashed state from
  the stash list.

## IMPROVEMENTS

* Updated the bundled libgit2 source code to v0.27.2 (8d36dc6).

* git2r can now build against a system installation of libgit2
  (Elliott Sales de Andrade in PR #345, #344 and #336).

* Refactoring of the configuration scripts to use a prebuilt libgit2
  on macOS and Windows (Thanks Jeroen).

* Ensure that git2r writes the config file to the correct location on
  Windows (John Blischak in PR #320).

* Better default location to find ssh keys in 'cred_ssh_key()' (Ian
  Lyttle in PR #317).

## BUG FIXES

* If a merge results in no change, the returned 'git_merge_result' now returns
  'FALSE' for 'fast_forward' and 'conflicts' and 'NA' for 'sha'. Previously it
  returned 'logical(0)' for 'fast_forward' and 'conflicts' and 'character(0)'
  for 'sha'.

## BREAKING CHANGES

* Changed from S4 classes to S3 classes to simplify the design and
  facilitate future development.

* Removed the trailing slash from the directory name when reporting
  repository path or workdir.

* Removed the 'libgit2_sha' method. Use the 'libgit2_version' method
  instead.

* Changed the 'stash_drop' argument 'index' from zero-based to
  one-based i.e. use index = 1 to drop the first stash.

# git2r 0.21.0 (2018-01-04)

* Added methods 'odb_blobs' and 'odb_objects' with missing repository
  signature. Internally, they use 'getwd' and 'discover_repository' to
  open a repository.

## BUG FIXES

* The bundled libgit2 source code has been reverted to libgit2 v0.26.0
  (15e1193) from 14 June 2017 (same as in git2r v0.19.0) to fix memory
  alignment errors.

# git2r 0.20.0 (2017-12-17)

## IMPROVEMENTS

* Updated the bundled libgit2 source code to commit (fa8cf14) from 16
  December 2017.

* Improvements to the build configuration script.

## BUG FIXES

* Fixed the internal callback for remote host authentication from
  hanging indefinitely when querying an ssh-agent for
  credentials. Now, the callback signals an error instead of trying
  again if the authentication failed the first time.

# git2r 0.19.0 (2017-07-19)

## IMPROVEMENTS

* Updated the bundled libgit2 source code to commit (15e1193)
  (v0.26.0) from 14 June 2017.

* Added 'checkout' argument to 'clone()'. Allows to control whether
  checkout of HEAD is performed after the clone is complete. Setting
  'checkout=FALSE' has similar effect as the git command line option
  '--no-checkout'. Andrzej K. Oles in #282.

## BUG FIXES

* Fixed memory protection errors in the git2r C source code reported
  by the 'rchk' tool.

* Added missing calls to 'R_forceSymbols' and 'R_useDynamicSymbols' in
  the C init function.

* Enable argument 'all' to commit multiple modified (or deleted)
  files. John Blischak in #283

* Changed the configure script to determine the architecture of the
  machine earlier in order to fix an unsupported architecture error
  encountered on CentOS (#268, #288).

# git2r 0.18.0 (2017-01-01)

## BUG FIXES

* This is a bug-fix release to solve an error introduced in the build
  configuration on mac in version 0.17.0. The package failed with
  'unable to load shared object', see issue #267.

# git2r 0.17.0 (2016-12-29)

## IMPROVEMENTS

* Updated the bundled libgit2 source code to commit (6b0510e) from 20
  December 2016.

* Static linking of LibSSH2 on mac to support redistributable binary
  package with SSH transport enabled. Version 1.8.0 of LibSSH2 is
  downloaded and built from 'https://www.libssh2.org/download/'.

# git2r 0.16.0 (2016-11-20)

## IMPROVEMENTS

* Updated libgit2 source code to commit (6b0510e) from
  17 November 2016.

* Add the option 'all_untracked' to the 'status' method to show
  individual files in untracked directories if the 'untracked' option
  is TRUE.

* Add the 'tag_delete' method to delete an existing tag reference.

* Update build configuration to support OpenSSL 1.1.0.

* If the the 'getPass' package is installed the 'cred_ssh_key' method
  to create a new passphrase-protected ssh key credential object will
  call the 'getPass::getPass()' method if the private key is
  passphrase protected to allow for interactive input of the
  passphrase. The 'getPass' package is a suggested package. (Peter
  Meissner in PR #254)

* Add 'path' argument to the 'reset' method to enable path-specific
  unstage, i.e. resets the index entries for all paths to their state
  at HEAD

## BUG FIXES

* Build configuration: use portable string equality comparison
  operator. This fixes the build e.g. for those without Bash as
  /bin/sh. (Sander Maijers in PR #243).

# git2r 0.15.0 (2016-05-11)

## IMPROVEMENTS

* Build configuration: 'pkg-config' is now used to find 'libssl', if
  possible (Elias Pipping in PR #231).

* Added a method to coerce a 'git_commit' object to a 'data.frame'.

* Added the method 'is_branch' to check if an object is a
  'git_branch'.

## BUG FIXES

* Build configuration: fixed installation with parallel make (Kirill
  Müller in PR #228).

# git2r 0.14.0 (2016-03-13)

## IMPROVEMENTS

* Updated libgit2 source code to commit (785d8c48) from
  2016-03-04. This is release v0.24.0 of libgit2.

* Refactoring of the build scripts.

* Added a check that the configuration key is valid when setting a
  configuration variable and output a warning if the key is invalid.

* The status method now prints "working directory clean" instead of
  nothing when the working directory is clean.

* Added the 'refspec' argument to the 'fetch' method to specify the
  refs to fetch and which local refs to update.

* Added a workaround to the 'commit' method to list commits in a
  shallow clone since the libgit2 library does not yet support this.

# git2r 0.13.1 (2015-12-10)

## BUG FIXES

* This is a bug-fix release to solve problems introduced in version
  0.12.1:

  - The bundled libgit2 source code has been reverted to commit
    (98f7bd2) from 2015-08-05 (same as in v0.11.0) to fix memory
    alignment errors (clang-UBSAN and gcc-UBSAN).

  - OpenSSL is now used again on OS X to provide the cryptographic
    support for HTTPS connections to fix a significant compiler
    warning (arithmetic on a pointer to void is a GNU extension
    [-Wpointer-arith]) on r-devel-osx-x86_64-clang.

  - Several fixes to the build configuration on non-Windows platforms.

# git2r 0.12.1 (2015-12-05)

## NEW FEATURES

* Add 'remote_ls' method to list references in a remote repository akin to the
  `git ls-remote` command.

* Add 'remote_set_url' method to set the remote's url in the
  configuration.

* Add 'cred_token' S4 class to hold the name of the environmental
  variable with the secret. Default value for the name is GITHUB_PAT.

* It is now possible to checkout a specific file with the 'checkout'
  method.

* Add 'ssl_cert_locations' method to set libgit2 global option
  'GIT_OPT_SET_SSL_CERT_LOCATIONS'

* Add 'ceiling' argument to 'discover_repository' method to prevent
  search from walking up the parent directories.

## CHANGES

* Improvments to the cred_* functions documentation.

* Add the following default arguments to the 'cred_ssh_key' method:
  publickey = '~/.ssh/id_rsa.pub' and privatekey = '~/.ssh/id_rsa'

* On OSX, cascade CPPFLAGS and LDFLAGS to libssh2 build to allow
  libssh2 to be built against a user-installed openssl, discovered by
  configure or from R's Makeconf. Necessary to build on OS X ≥ 10.11

* On OS X, SecureTransport is now used to provide the cryptographic
  support for HTTPS connections insead of OpenSSL.

* The search for libssh2 during configuration (non Windows) is now
  done via pkg-config.

* Update OpenSSL on Windows to v1.0.2d

* Update libgit2 source code to commit (3f5877d) from 2015-11-12.

## BUG FIXES

* Add missing credentials argument to pull method.

* Fix config failure when user.name or user.email are passed as
  variables.

* Include 'configure.ac' in the distribution.

# git2r 0.11.0 (2015-08-12)

## NEW FEATURES

* Add punch card plot.

* Add branch argument to clone with name of the branch to checkout.

* Add 'force' argument to 'add' method to add ignored files.

* The following methods can now be called without the repository
  argument: 'branches', 'references', 'remotes', 'tags' and 'workdir'.
  When these methods are called without the repository argument, the
  repository is searched for with 'discover_repository' in the current
  working directory.

* Add name of branch to each item in branch_list.

* Add name of tag to each item in tags list.

* Add S4 class 'cred_env' to pass credentials in environment
  variables.

* SSH transport on Windows. This requires 'LibSSH2' and
  'OpenSSL'. These two libraries are downloaded from
  'https://github.com/rwinlib' during configuration of the package.

* Static linking of LibSSH2 on OSX to support redistributable binary
  package with SSH transport enabled. Version 1.6.0 of LibSSH2 is
  downloaded and built from 'https://github.com/libssh2/libssh2'.

## IMPROVEMENTS

* Better summary output from S4 classes 'git_commit' and
  'git_repository'.

* Updated libgit2 source code to commit (98f7bd2) from 2015-08-05.

## BUG FIXES

* Add imports to DESCRIPTION to fix CRAN notes.

* Fix plot function to use the repository argument 'x'

* Update configuration to build on OpenBSD.

* Fix checkout branch in empty repository.

* Fix path argument in rm_file.

* Internal refactoring of C code that raise error to prevent segfault.

# git2r 0.10.1 (2015-05-07)

## CHANGES

* Rename 'bundle_repo' method to 'bundle_r_package'

# git2r 0.10.0 (2015-05-07)

## NEW FEATURES

* Added method libgit2_sha that returns the commit id of the libgit2
  library that the bundled source code is based on.

* Added the method in_repository to determine if a directory is in a
  git repository.

## CHANGES

* Add brief summary of the five latest commits when summarizing a
  git_respository.

* Added argument 'n' to the commits method to limit the number of
  commits in the output.

* Added the following methods with missing repository signature;
  commits, is_shallow, is_empty, is_detached, repository and
  status. Internally, these methods use getwd and discover_repository
  to open a repository.

* Changed configuration to raise error if the OpenSSL library is not
  found on non-Windows systems.

* Changed configuration to raise error if the iconv library is not
  found on OSX.

* Removed print of the configuration in the config method. Changed to
  return S3 class git_config.

* Removed print of the status in the status method. Changed to return
  S3 class git_status.

## BUG FIXES

* Use OPENSSL_INCLUDES variable to build on Solaris.

* Use bundled regex library on Solaris.

git2 0.9 (2015-04-25)

## CHANGES

* Single quote 'libgit2' and 'Git' in Description field

git2 0.8 (2015-04-24)

## CHANGES

* Added bare argument to clone method to create a bare repository

* Added force argument to push to force local revision to the remote
  repo

* Updated libgit2 source code (2a0f67f)

* Internal refactoring of push

## NEW FEATURES

* Added method rm_file to remove files

* Added 'all' argument to commit method to stage modified and deleted
  files

* Added shortcut to checkout previous branch with "-" which is
  synonymous with "@{-1}"

* Added session argument to commit method to add sessionInfo to commit
  message

* Added session argument to tag method to add sessionInfo to tag
  message

* Added  method to coerce POSIXlt to S4 class git_time

* Added method 'revparse_single' to find object specified by revision

* Added plot method

git2 0.7 (2015-02-23)

## CHANGES

* Update libgit2 source code to commit (366e53d)

* Fix configuration of compiler options when the OpenSSL library is
  found on non-Windows platforms

# git2r 0.6 (2015-02-18)

## CHANGES

* Update Title and Description field in DESCRIPTION file.

# git2r 0.5 (2015-02-17)

## CHANGES

* Update libgit2 source code to commit (a291790)

* Use Alice and Bob as placeholder names in examples.

* Add COPYRIGHTS file to list all copyright holders.

* Fix significant compiler warnings from R CMD check with pedantic
  flag.

# git2r 0.4 (2015-01-13)

## CHANGES

* Fix build on Windows

# git2r 0.3 (2015-01-13)

## CHANGES

* Internal refactoring of merge method and merge tests.

* Update libgit2 source code to version v0.22.0

## BUG FIXES

* Fix build on OSX.

# git2r 0.2 (2015-01-05)

## NEW FEATURES

* Add method 'odb_objects' to list all objects available in the
  database as a data.frame

* Add method 'odb_blobs' to list all blobs reachable from the commits
  in the object database.

## DOCUMENTATION

* Added examples to all exported methods.

## CHANGES

* Removed ggplot2 dependency. Moved plot functionality to the ggit
  package (https://github.com/ropensci/ggit).

* Renamed note_list method to notes

* Removed markdown_link method

* Renamed diff and merge arguments

## IMPROVEMENTS

* Better performance when summarizing contributions.

* Improved build of package.

## BUG FIXES

* Fixed memory leaks.

* Fixed use of allocVector without protection.

* Added unload hook to unload DLL.

* Fix tree and blob tests to use writeChar instead of writeLines to
  have more control over line endings.

# git2r 0.1 (2014-09-09)

## NEW FEATURES

* Many new features and methods added, see the documention for a
  description of the methods below:

  - Blob: content, blob_create, hash, hashfile, is_binary, is_blob,
          length, show, summary.
  - Branch: branch_create, branch_delete, branch_get_upstream,
            branch_remote_name, branch_remote_url, branch_rename,
            branch_set_upstream and branch_target.
  - Commit: is_commit and parents.
  - Diff: diff and diff_print.
  - Fetch: fetch and fetch_heads.
  - Libgit2: libgit2_features and libgit2_version.
  - Merge: merge.
  - Note: note_create, note_default_ref, note_list and note_remove.
  - Pull: pull.
  - Push: push.
  - Remote: remote_add, remote_remove, remote_rename and remote_url.
  - Repository: discover_repository and is_shallow
  - Reset: reset.
  - Stash: stash, stash_drop, stash_list, show and summary.

* Improved error messages to give more detailed information including
  which function raised the error.

## NEW S4 CLASSES

* The following new S4 classes to handle the libgit2 data structures:
  - cred_ssh_key
  - cred_user_pass
  - git_blame
  - git_blame_hunk
  - git_blob
  - git_diff
  - git_diff_file
  - git_diff_hunk
  - git_diff_line
  - git_fetch_head
  - git_merge_result
  - git_note
  - git_reflog_entry
  - git_stash
  - git_transfer_progress
  - git_tree

## CHANGES

* Renamed methods:
  - is.bare to is_bare
  - is.empty to is_empty
  - is.head to is_head
  - is.local to is_local

* Rename hex to sha for the 40-character SHA-1 hash in method
  arguments and S4 class slots.

# git2r 0.0.8 (2014-03-20)

## NEW FEATURES

* Added method to clone repository

* Added method config to set user.name and user.email in a repository

* Added method status to display state of a repository

# git2r 0.0.7 (2014-03-16)

## NEW FEATURES

* Added method to create a commit

## CHANGES

* Improved error checking

# git2r 0.0.6 (2014-02-21)

## NEW FEATURES

* Added method init to create a new Git repository

## CHANGES

* Removed usage of testthat package when testing the package

* Removed bundled zlib in src/zlib and instead link against zlib
  shipped with R.

* Dropped usage of external pointers, S4 git_repository now keeps
  track of the path of the repository.

# git2r 0.0.5 (2014-01-01)

## CHANGES

* Renamed S4 class repository to git_repository

## NEW FEATURES

* Added method commits to list all commits in repository

* Added S4 class git_commit to hold infformation of a commit

* Added S4 class git_time to hold time of an action

* Added slot walker to S4 class git_repository

# git2r 0.0.4 (2013-12-30)

## NEW FEATURES

* Added method remote_url to get the url a remote in a repository

* Added method workdir to get workdir of a repository

* Added method remotes to list remotes of a repository

* Added S4 class git_signature to hold information of an action
  signature (e.g. for committers, taggers, etc)

## CHANGES

* Renamed S4 class tag to git_tag

* Renamed S4 class branch to git_branch

* Renamed S4 class reference to git_reference

# git2r 0.0.3 (2013-12-29)

## NEW FEATURES

* Added method branches to list branches

* Added method head to retrieve head

* Added method is.head to check if a branch is head

* Added method is.local to check if a branch is local

* Added S4 class branch to hold information of a git branch

* Added method to show a reference

* Added method to list all references in a repository

* Added S4 class reference to hold information of a git reference

# git2r 0.0.2 (2013-12-28)

## NEW FEATURES

* Added is.bare method to check if a repository is bare

* Added is.empty method to check if a repository is empty

# git2r 0.0.1 (2013-12-28)

## NEW FEATURES

* Added S4 class repository to work with a git repository

* Initial package structure
