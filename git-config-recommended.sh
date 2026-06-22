#!/bin/bash

# Git Recommended configuration
    # These settings are meant to be nearly universal.
    # They should be applicable on every computer and should be fine to include in your global ~/.gitconfig.

    # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
    set -euxo pipefail

# Prevent global name and email
    # Instruct Git to avoid trying to guess defaults for user.email and user.name, and instead retrieve the values only from the configuration.
    # For example, if you have multiple email addresses and would like to use a different one for each repository, then with this configuration option set to true in the global config along with a name, Git will prompt you to set up an email before making new commits in a newly cloned repository.
    # Defaults to false.
    # https://blog.github.com/2016-03-28-git-2-8-has-been-released/#dont-guess-my-identity
    # https://git-scm.com/docs/git-config#Documentation/git-config.txt-useruseConfigOnly
    git config --global user.useConfigOnly true

# Aliases
    # Shorthand aliases
        # Aliases from the git-scm book https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases
        git config --global alias.co      checkout
        git config --global alias.br      branch
        git config --global alias.ci      commit
        git config --global alias.st      status
        git config --global alias.unstage 'reset HEAD --'
        git config --global alias.last    'log -1 HEAD'
        # Aliases of my own that seem to be pretty common
        git config --global alias.cp      cherry-pick
        git config --global alias.oops    'commit --amend --no-edit'
        # there is no configuration available to tell git to always use `force-with-lease` instead of `force`
        # https://stackoverflow.com/a/30567394/23572
        git config --global alias.pushf   'push --force-with-lease'

    # Aliases for plurals. Otherwise, git has inconsistent commands to list all branches, tags, stashes, workrees, remotes, aliases.
        # Plurals from http://gggritso.com/human-git-aliases
        git config --global alias.branches  'branch --all'
        git config --global alias.tags      'tag --list'
        git config --global alias.stashes   'stash list'
        # https://stackoverflow.com/a/7067489/23572
        git config --global alias.aliases   'config --get-regexp ^alias\.'
        # More plurals
        git config --global alias.worktrees 'worktree list'
        git config --global alias.remotes   'remote --verbose'

    # submodule configuration
        # Diffs of submodules should show the changed contents rather than a list of commits.
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-diffsubmodule
            # Change from 'short' to 'diff'
            git config --global diff.submodule diff
        # git status should show a summary of commits for modified submodules.
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-statussubmoduleSummary
            git config --global status.submoduleSummary true
        # git push should recurse into submodules on-demand
            # all submodules that changed in the revisions to be pushed will be pushed
            # Change from 'no' to 'on-demand'
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-pushrecurseSubmodules
            git config --global push.recurseSubmodules on-demand

    # diff
        # Git should detect both renames and copies. Theoretically slows down git.
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-diffrenames
            # Change from 'true' to 'copies'
            git config --global diff.renames copies
        # git diff should use a prefix pair that is different from the standard "a/" and "b/" depending on what is being compared. Only relevant when not piping through a pager/formatter like diff-so-fancy.
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-diffmnemonicPrefix
            git config --global diff.mnemonicPrefix true
        # Highlight moved code blocks
            # https://blog.gitbutler.com/how-git-core-devs-configure-git#better-diff
            git config --global diff.colorMoved plain

    # merge
        # Show the common ancestor ("base") in conflict markers, in addition to
        # the two conflicting sides. zdiff3 is like diff3 but moves common lines
        # out of the conflict region for smaller, clearer conflicts.
            # Added in Git 2.35. Default is 'merge' (no base shown).
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-mergeconflictStyle
            git config --global merge.conflictStyle zdiff3

    # rerere
        # Reuse recorded resolution
            # The git rerere functionality is a bit of a hidden feature. The name stands for "reuse recorded resolution" and, as the name implies, it allows you to ask Git to remember how you’ve resolved a hunk conflict so that the next time it sees the same conflict, Git can resolve it for you automatically.
            # https://git-scm.com/book/en/v2/Git-Tools-Rerere
        # Enable rerere
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-rerereenabled
            # https://stackoverflow.com/questions/5519244/are-there-any-downsides-to-enabling-git-rerere
            git config --global rerere.enabled true
        # rerere should update the index, not just the worktree.
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-rerereautoUpdate
            git config --global rerere.autoUpdate true

    # branch
        # When a new branch is created with git branch or git checkout that tracks another branch, git should set up pull to rebase instead of merge.
            # Change from 'never' to 'always'
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-branchautoSetupRebase
            git config --global branch.autoSetupRebase always

        # Tells git branch, git switch and git checkout to set up new branches so that git-pull will merge from the starting point branch.
        # true: automatic setup is done when the starting point is a remote-tracking branch;
        # always: automatic setup is done when the starting point is either a local branch or remote-tracking branch;
            # Change from 'true' to 'always'
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-branchautoSetupMerge
            git config --global branch.autoSetupMerge always

    # Log decorations
        # Print out the ref names of any commits that are shown by the log command.
        # If short is specified, the ref name prefixes refs/heads/, refs/tags/ and refs/remotes/ will not be printed.
        # If full is specified, the full ref name (including prefix) will be printed.
        # If auto is specified, then if the output is going to a terminal, the ref names are shown as if short were given, otherwise no ref names are shown.
        # This is the same as the --decorate option of the git log.
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-logdecorate
        git config --global log.decorate short

    # AutoStash
        # Automatically stash local changes before rebase and merge operations.
            # Create a temporary stash entry before and apply it after.
            # This means that you can run rebase on a dirty worktree.
            # Use with care: the final stash application after a successful rebase might result in non-trivial conflicts.
            # This option can be overridden by the --no-autostash and --autostash options of git-rebase.
        # Auto-stash before rebase
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-rebaseautoStash
            # https://blog.gitbutler.com/how-git-core-devs-configure-git#slightly-nicer-rebase
            git config --global rebase.autoStash true
        # Auto-stash before merge
            # https://stackoverflow.com/a/30209750/23572
            # Added in Git 2.27.
            git config --global merge.autoStash true

    # rebase
        # https://github.blog/2022-10-03-highlights-from-git-2-38/#rebase-dependent-branches-with-update-refs
        git config --global rebase.updateRefs true
        # https://blog.gitbutler.com/how-git-core-devs-configure-git#slightly-nicer-rebase
        git config --global rebase.autoSquash true

    # git log should act as if the --follow option was used when a single <path> is given
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-logfollow
        # https://git-scm.com/docs/git-log#Documentation/git-log.txt---follow
        # Continue listing the history of a file beyond renames (works only for a single file).
        git config --global log.follow true

    # git stash show (without an option) should show the stash entry in patch form.
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-stashshowPatch
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-stashshowStat
        git config --global stash.showPatch true

    # Performance
        # Use merge-ort merge strategy
            # https://github.blog/2021-08-16-highlights-from-git-2-33/#merge-ort-a-new-merge-strategy
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-pulltwohead
            git config --global pull.twohead ort

        # Use file system monitor
            # https://github.blog/2022-06-29-improve-git-monorepo-performance-with-a-file-system-monitor/
            # added in Git version 2.37.0
            git config --global core.fsmonitor true
            git config --global core.untrackedcache true

    # Default branch name
        # https://github.blog/2020-07-27-highlights-from-git-2-28/#introducing-init-defaultbranch
        git config --global init.defaultBranch main

    # Tag sorting
        # https://blog.gitbutler.com/how-git-core-devs-configure-git#listing-tags
        git config --global tag.sort version:refname

    # Push
        # https://blog.gitbutler.com/how-git-core-devs-configure-git#better-pushing
        git config --global push.default simple
        git config --global push.autoSetupRemote true

    # Help autocorrect
        # https://blog.gitbutler.com/how-git-core-devs-configure-git#autocorrect-prompting
        # Example:
        # git helo
        # WARNING: You called a Git command named 'helo', which does not exist.
        # Run 'help' instead [y/N]?
        git config --global help.autocorrect prompt

    # Remote
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-remotepushDefault
        # The remote to push to by default. Overrides branch.<name>.remote for all branches, and is overridden by branch.<name>.pushRemote for specific branches.
        git config --global remote.pushDefault origin
