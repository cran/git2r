/*
 *  git2r, R bindings to the libgit2 library.
 *  Copyright (C) 2013-2015 The git2r contributors
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License, version 2,
 *  as published by the Free Software Foundation.
 *
 *  git2r is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#ifndef INCLUDE_git2r_arg_h
#define INCLUDE_git2r_arg_h

#include <R.h>
#include <Rinternals.h>

int git2r_arg_check_blob(SEXP arg);
int git2r_arg_check_branch(SEXP arg);
int git2r_arg_check_commit(SEXP arg);
int git2r_arg_check_credentials(SEXP arg);
int git2r_arg_check_fetch_heads(SEXP arg);
int git2r_arg_check_filename(SEXP arg);
int git2r_arg_check_sha(SEXP arg);
int git2r_arg_check_integer(SEXP arg);
int git2r_arg_check_integer_gte_zero(SEXP arg);
int git2r_arg_check_list(SEXP arg);
int git2r_arg_check_logical(SEXP arg);
int git2r_arg_check_note(SEXP arg);
int git2r_arg_check_signature(SEXP arg);
int git2r_arg_check_string(SEXP arg);
int git2r_arg_check_string_vec(SEXP arg);
int git2r_arg_check_tag(SEXP arg);
int git2r_arg_check_tree(SEXP arg);

#endif
