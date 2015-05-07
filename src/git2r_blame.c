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

#include <Rdefines.h>
#include "git2.h"

#include "git2r_arg.h"
#include "git2r_blame.h"
#include "git2r_error.h"
#include "git2r_repository.h"
#include "git2r_signature.h"

/**
 * Init slots in S4 class git_blame
 *
 * Iterates over and init each git_blame_hunk
 * @param source a blame object
 * @param repo S4 class git_repository that contains the blob
 * @param path The path to the file to get the blame
 * @param dest S4 class git_blame to initialize
 * @return void
 */
void git2r_blame_init(git_blame *source, SEXP repo, SEXP path, SEXP dest)
{
    SEXP hunks;
    size_t i, n;

    n = git_blame_get_hunk_count(source);
    SET_SLOT(dest, Rf_install("hunks"), hunks = allocVector(VECSXP, n));
    for (i = 0; i < n; i++) {
        const git_blame_hunk *hunk;

        hunk = git_blame_get_hunk_byindex(source, i);
        if (hunk) {
            SEXP item;
            char sha[GIT_OID_HEXSZ + 1];

            SET_VECTOR_ELT(
                hunks,
                i,
                item = NEW_OBJECT(MAKE_CLASS("git_blame_hunk")));

            SET_SLOT(
                item,
                Rf_install("lines_in_hunk"),
                ScalarInteger(hunk->lines_in_hunk));

            git_oid_fmt(sha, &(hunk->final_commit_id));
            sha[GIT_OID_HEXSZ] = '\0';
            SET_SLOT(item, Rf_install("final_commit_id"), mkString(sha));

            SET_SLOT(
                item,
                Rf_install("final_start_line_number"),
                ScalarInteger(hunk->final_start_line_number));

            git2r_signature_init(
                hunk->final_signature,
                GET_SLOT(item, Rf_install("final_signature")));

            git_oid_fmt(sha, &(hunk->orig_commit_id));
            sha[GIT_OID_HEXSZ] = '\0';
            SET_SLOT(item, Rf_install("orig_commit_id"), mkString(sha));

            SET_SLOT(
                item,
                Rf_install("orig_start_line_number"),
                ScalarInteger(hunk->orig_start_line_number));

            git2r_signature_init(
                hunk->orig_signature,
                GET_SLOT(item, Rf_install("orig_signature")));

            SET_SLOT(item, Rf_install("orig_path"), mkString(hunk->orig_path));

            if (hunk->boundary)
                SET_SLOT(item, Rf_install("boundary"), ScalarLogical(1));
            else
                SET_SLOT(item, Rf_install("boundary"), ScalarLogical(0));

            SET_SLOT(item, Rf_install("repo"), repo);
        }
    }

    SET_SLOT(dest, Rf_install("path"), path);
    SET_SLOT(dest, Rf_install("repo"), repo);
}

/**
 * Get the blame for a single file
 *
 * @param repo S4 class git_repository that contains the blob
 * @param path The path to the file to get the blame
 * @return S4 class git_blame
 */
SEXP git2r_blame_file(SEXP repo, SEXP path)
{
    int err;
    SEXP result = R_NilValue;
    git_blame *blame = NULL;
    git_repository *repository = NULL;
    git_blame_options blame_opts = GIT_BLAME_OPTIONS_INIT;

    if (git2r_arg_check_string(path))
        git2r_error(git2r_err_string_arg, __func__, "path");

    repository = git2r_repository_open(repo);
    if (!repository)
        git2r_error(git2r_err_invalid_repository, __func__, NULL);

    err = git_blame_file(
        &blame,
        repository,
        CHAR(STRING_ELT(path, 0)),
        &blame_opts);
    if (GIT_OK != err)
        goto cleanup;

    PROTECT(result = NEW_OBJECT(MAKE_CLASS("git_blame")));
    git2r_blame_init(blame, repo, path, result);

cleanup:
    if (blame)
        git_blame_free(blame);

    if (repository)
        git_repository_free(repository);

    if (R_NilValue != result)
        UNPROTECT(1);

    if (GIT_OK != err)
        git2r_error(git2r_err_from_libgit2, __func__, giterr_last()->message);

    return result;
}
