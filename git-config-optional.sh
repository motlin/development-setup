#!/bin/bash

# Git optional configuration
    # The configuration here is a matter of taste, or depends on the way you work or the machine you work on.
    # Usually you ought to configure these keys, but not necessarily with the same values.
    # Although I configure these globally, you may want to configure them per repository.

    # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
    set -euxo pipefail


# On/Off
    # git should delete the .orig file after merge conflicts are resolved.
        # It seems safer to keep the backup files, but git has so many other ways to recover work.
        # After performing a merge, the original file with conflict markers can be saved as a file with a .orig extension.
        # If this variable is set to false then this file is not preserved.
        # Defaults to true (i.e. keep the backup files).
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-mergetoolkeepBackup
        git config --global mergetool.keepBackup false

    # During `git rebase --interactive`, prevent (accidental) deletion of lines
        # If set to "warn", git rebase -i will print a warning if some commits are removed (e.g. a line was deleted), however the rebase will still proceed.
        # If set to "error", it will print the previous warning and stop the rebase, git rebase --edit-todo can then be used to correct the error.
        # If set to "ignore", no checking is done.
        # To drop a commit without warning or error, use the drop command in the todo list.
        # Defaults to "ignore".
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-rebasemissingCommitsCheck
        git config --global rebase.missingCommitsCheck error
    # rebase branches on top of the fetched branch
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-pullrebase
        git config --global pull.rebase merges

# Depends on software

    # line endings
        # Ensure that Git is properly configured to handle line endings.
        # https://help.github.com/articles/dealing-with-line-endings/
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-coreautocrlf
        # Windows:
        # git config --global core.autocrlf true
        # Mac and Linux:
        git config --global core.autocrlf input
    # long file names
        # Fix "Filename too long" errors in Windows
        git config --system core.longpaths true

# Depends on taste
    # wordRegex
        # When runing git diff --color-words, git uses this regex to determinate word boundaries.
        # https://git-scm.com/docs/git-config#git-config-diffwordRegex
        # https://medium.com/@porteneuve/30-git-cli-options-you-should-know-about-15423e8771df
        git config --global diff.wordRegex .
    # autoCorrect
        # Automatically correct and execute mistyped commands after waiting for the given number of deciseconds (0.1 sec). For example:
        # git helo
        # WARNING: You called a Git command named 'helo', which does not exist.
        # Continuing in 2.0 seconds, assuming that you meant 'help'.
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-helpautoCorrect
        git config --global help.autoCorrect 20
