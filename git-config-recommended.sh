#!/bin/bash

# Git Recommended configuration
    # These settings are meant to be nearly universal.
    # They should be applicable on every computer and should be fine to include in your global ~/.gitconfig.

    # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
    set -euxo pipefail

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

    # Aliases for plurals. Otherwise, git has inconsistent commands to list all branches, tags, stashes, wortrees, remotes, aliases.
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

    # AutoStash
        # Automatically stash local changes before rebase and merge operations.
            # Create a temporary stash entry before and apply it after.
            # This means that you can run rebase on a dirty worktree.
            # Use with care: the final stash application after a successful rebase might result in non-trivial conflicts.
            # This option can be overridden by the --no-autostash and --autostash options of git-rebase.
        # Auto-stash before rebase
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-rebaseautoStash
            git config --global rebase.autoStash true
        # Auto-stash before merge
            # https://stackoverflow.com/a/30209750/23572
            # Coming in Git 2.27. Current version at time of writing is 2.26.2.
            git config --global merge.autoStash true

    # rebase
        # https://github.blog/2022-10-03-highlights-from-git-2-38/#rebase-dependent-branches-with-update-refs
        git config --global rebase.updateRefs true

    # git log should act as if the --follow option was used when a single <path> is given
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-logfollow
        git config --global log.follow true

    # git stash show (without an option) should show the stash entry in patch form.
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-stashshowPatch
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-stashshowStat
        git config --global stash.showPatch true

    # Use the commit graph
        # The commit graph is a major optimization, introduced starting in 2.18 and eventually made the default in 2.24.
            # https://devblogs.microsoft.com/devops/supercharging-the-git-commit-graph/
        # Enable commit graph
            # Defaults to true in 2.24
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-corecommitGraph
            git config --global core.commitGraph true
        # Update commit graph during garbage collection
            # Defaults to true in 2.24
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-gcwriteCommitGraph
            git config --global gc.writeCommitGraph true
        # Update commit graph during fetch
            # Defaults to false, unless feature.experimental is true.
            # Default to false at time of writing with git 2.26.2.
            # https://github.blog/2019-11-03-highlights-from-git-2-24/
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-fetchwriteCommitGraph
            git config --global fetch.writeCommitGraph true

    # Performance
        # Use On-disk reverse indexes
            # https://github.blog/2021-03-15-highlights-from-git-2-31/#on-disk-reverse-indexes
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-packwriteReverseIndex
            # Defaults to false at time of writing with git 2.31
            # Manually run `git repack -Ad` to get the `.rev` file written to disk once.
            git config --global pack.writeReverseIndex true
        # Use merge-ort merge strategy
            # https://github.blog/2021-08-16-highlights-from-git-2-33/#merge-ort-a-new-merge-strategy
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-pulltwohead
            git config --global pull.twohead ort
        # Use sparse packs
            # This can have significant performance benefits when computing a pack to send a small change.
            # https://devblogs.microsoft.com/devops/exploring-new-frontiers-for-git-push-performance/
            # https://git-scm.com/docs/git-config#Documentation/git-config.txt-packuseSparse
            # Default is false unless feature.experimental is enabled.
            git config --global pack.useSparse true

        # Use file system monitor
            # https://github.blog/2022-06-29-improve-git-monorepo-performance-with-a-file-system-monitor/
            # added in Git version 2.37.0
            git config --global core.fsmonitor true
            git config --global core.untrackedcache true

    # Protocol v2
        # major update of Git's wire protocol
        # https://opensource.googleblog.com/2018/05/introducing-git-protocol-version-2.html
        # https://git-scm.com/docs/git-config/#Documentation/git-config.txt-protocolversion
        # Added in 2.19. Default in 2.26.
        git config --global protocol.version 2

    # Default branch name
        # https://github.blog/2020-07-27-highlights-from-git-2-28/#introducing-init-defaultbranch
        git config --global init.defaultBranch main

    # Remote
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-remotepushDefault
        # The remote to push to by default. Overrides branch.<name>.remote for all branches, and is overridden by branch.<name>.pushRemote for specific branches.
        git config --global remote.pushDefault origin
