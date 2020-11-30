#!/bin/bash

# Git optional configuration
    # The configuration here is a matter of taste, or depends on the way you work or the machine you work on.
    # Usually you ought to configure these keys, but not necessarily with the same values.
    # Although I configure these globally, you may want to configure them per repository.

    # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
    set -euxo pipefail


# On/Off
    # Prevent global name and email
        # Instruct Git to avoid trying to guess defaults for user.email and user.name, and instead retrieve the values only from the configuration.
        # For example, if you have multiple email addresses and would like to use a different one for each repository, then with this configuration option set to true in the global config along with a name, Git will prompt you to set up an email before making new commits in a newly cloned repository.
        # Defaults to false.
        # https://blog.github.com/2016-03-28-git-2-8-has-been-released/#dont-guess-my-identity
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-useruseConfigOnly
        git config --global user.useConfigOnly true

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
    # fsmonitor
        # Git 2.16 added support for a core.fsmonitor hook to allow an external tool to inform it which files have changed.
        # blog.github.com/2018-04-05-git-217-released/#speeding-up-status-with-watchman
        # On repositories with many files, this can be a dramatic speedup.
        # https://git-scm.com/docs/githooks#_fsmonitor_watchman
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-corefsmonitor
        # First install rs-git-fsmonitor, or a competitor
        # https://github.com/jgavris/rs-git-fsmonitor
        git config --global core.fsmonitor rs-git-fsmonitor

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
    # Log decorations
        # Print out the ref names of any commits that are shown by the log command.
        # If short is specified, the ref name prefixes refs/heads/, refs/tags/ and refs/remotes/ will not be printed.
        # If full is specified, the full ref name (including prefix) will be printed.
        # If auto is specified, then if the output is going to a terminal, the ref names are shown as if short were given, otherwise no ref names are shown.
        # This is the same as the --decorate option of the git log.
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-logdecorate
        git config --global log.decorate full

