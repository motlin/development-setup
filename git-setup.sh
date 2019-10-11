#!/bin/bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


# Very common aliases
# First a few from the git book that everyone seems to use
# https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
# Next a few of my own that also seem to be pretty common
git config --global alias.cp cherry-pick
git config --global alias.oops 'commit --amend --no-edit'
# Consistent commands to list all branches, tags, stashes, aliases
  # https://github.com/GitAlias/gitalias/blob/master/gitalias.txt
  # Friendly wording is easier to remember.
  # Thanks to http://gggritso.com/human-git-aliases
git config --global alias.branches 'branch --all'
git config --global alias.tags 'tags'
git config --global alias.stashes 'stash list'
  # https://stackoverflow.com/a/7067489/23572
git config --global alias.aliases 'config --get-regexp ^alias\.'

# git has some amazing hidden features and some terrible default configuration choices that everyone seems to change. In this section, I'm trying to only list those, and avoid personal preferences. You can think of these as bad defaults in git that ought to be changed.

# If you use different email addresses to commit to different git repositories on the same computer, it's best to avoid setting a global user.email or it's too easy to make mistakes. Git also tries to infer your email address as user@host in some situations.
# https://blog.github.com/2016-03-28-git-2-8-has-been-released/#dont-guess-my-identity
# Now you can tell Git not to guess, but rather to insist that you set user.name and user.email explicitly before it will let you commit:
git config --global user.useConfigOnly true

# Ensure that Git is properly configured to handle line endings. On OS X, you simply pass input to the configuration.
# https://help.github.com/articles/dealing-with-line-endings/
git config --global core.autocrlf input

# Git should detect both renames and copies. Theoretically slows down git.
# https://git-scm.com/docs/git-config#git-config-diffrenames
git config --global diff.renames copies

# Diffs of submodules should show the changed contents rather than a list of commits.
# https://git-scm.com/docs/git-config#git-config-diffsubmodule
git config --global diff.submodule diff

# git diff should use a prefix pair that is different from the standard "a/" and "b/" depending on what is being compared. Only relevant when not piping through diff-so-fancy.
# https://git-scm.com/docs/git-config#git-config-diffmnemonicPrefix
git config --global diff.mnemonicPrefix true

# When runing git diff --color-words, git uses this regex to determinate word boundaries.
# https://git-scm.com/docs/git-config#git-config-diffwordRegex
# https://medium.com/@porteneuve/30-git-cli-options-you-should-know-about-15423e8771df
git config --global diff.wordRegex .

# git status should show a summary of commits for modified submodules.
# https://git-scm.com/docs/git-config#git-config-statussubmoduleSummary
git config --global status.submoduleSummary true

# The git rerere functionality is a bit of a hidden feature. The name stands for "reuse recorded resolution" and, as the name implies, it allows you to ask Git to remember how you’ve resolved a hunk conflict so that the next time it sees the same conflict, Git can resolve it for you automatically.
# https://git-scm.com/book/en/v2/Git-Tools-Rerere
# https://git-scm.com/docs/git-config#git-config-rerereenabled
# https://stackoverflow.com/questions/5519244/are-there-any-downsides-to-enabling-git-rerere
git config --global rerere.enabled true

# git rerere should update the index, not just the worktree.
# https://git-scm.com/docs/git-config#git-config-rerereautoUpdate
git config --global rerere.autoUpdate true

# When a new branch is created with git branch or git checkout that tracks another branch, git should set up pull to rebase instead of merge.
# https://git-scm.com/docs/git-config#git-config-branchautoSetupRebase
git config --global branch.autoSetupRebase always

# git should always set up tracking for new branches, not just for remote branches.
# https://git-scm.com/docs/git-config#git-config-branchautoSetupMerge
git config --global branch.autoSetupMerge always

# git should delete the .orig file after merge conflicts are resolved. It seems safer to keep the backup files, but git has so many other ways to recover work.
# https://git-scm.com/docs/git-config#git-config-mergetoolkeepBackup
git config --global mergetool.keepBackup false

# Automatically correct and execute mistyped commands after waiting for the given number of deciseconds (0.1 sec). For example:
# git helo
# WARNING: You called a Git command named 'helo', which does not exist.
# Continuing in 2.0 seconds, assuming that you meant 'help'.
# https://git-scm.com/docs/git-config#git-config-helpautoCorrect
git config --global help.autoCorrect 20

# git fetch should unconditionally recurse into submodules
# https://git-scm.com/docs/git-config#git-config-fetchrecurseSubmodules
git config --global fetch.recurseSubmodules true

# git push should recurse into submodules on-demand
# https://git-scm.com/docs/git-config#Documentation/git-config.txt-pushrecurseSubmodules
# all submodules that changed in the revisions to be pushed will be pushed
git config --global push.recurseSubmodules on-demand

# there is no configuration available to tell git to always use `force-with-lease` instead of `force`
# https://stackoverflow.com/a/30567394/23572
git config --global alias.pushf "push --force-with-lease"

# git should create a temporary stash entry before a rebase and apply it after the rebase ends. This means that you can run rebase on a dirty worktree. However, use with care: the final stash application after a successful rebase might result in non-trivial conflicts. This option can be overridden by the --no-autostash and --autostash options of git-rebase.
# https://git-scm.com/docs/git-config#git-config-rebaseautoStash
git config --global rebase.autoStash true

# TODO
# Print out the ref names of any commits that are shown by the log command. If short is specified, the ref name prefixes refs/heads/, refs/tags/ and refs/remotes/ will not be printed. If full is specified, the full ref name (including prefix) will be printed. If auto is specified, then if the output is going to a terminal, the ref names are shown as if short were given, otherwise no ref names are shown. This is the same as the --decorate option of the git log.
# https://git-scm.com/docs/git-config#git-config-logdecorate
git config --global log.decorate full

# git stash show (without an option) should show the stash entry in patch form.
# https://git-scm.com/docs/git-config#git-config-stashshowPatch
git config --global stash.showPatch true

# git rebase --interactive should print a warning and stop the rebase if commits are removed (e.g. a line was deleted). To drop a commit without warning or error, use the drop command in the todo list. To proceed after an error, use git rebase --edit-todo.
# https://git-scm.com/docs/git-config#git-config-rebasemissingCommitsCheck
git config --global rebase.missingCommitsCheck error

# https://devblogs.microsoft.com/devops/exploring-new-frontiers-for-git-push-performance/
# https://git-scm.com/docs/git-config#Documentation/git-config.txt-packuseSparse
git config --global pack.useSparse true

# https://devblogs.microsoft.com/devops/supercharging-the-git-commit-graph/
# https://git-scm.com/docs/git-config#Documentation/git-config.txt-corecommitGraph
# https://git-scm.com/docs/git-config#Documentation/git-config.txt-gcwriteCommitGraph
git config --global core.commitGraph true
git config --global gc.writeCommitGraph true

# In the past, git has had some terrible default options that were fixed in later versions. If you are like me, you have some now-redundant configuration and can't remember why. These --unset commands can clean up some configuration that is no longer necessary assuming you're on a reasonably modern version of git. Be careful though, these commands do not check that your configuration is in fact redundant.


# https://git-scm.com/docs/git-config#git-config-pushdefault
# Defines the action git push should take if no refspec is explicitly given.
# Since Git 2.0, simple is the new default.
git config --global --unset push.default

# https://git-scm.com/docs/git-config#git-config-cleanrequireForce
# A boolean to make git-clean do nothing unless given -f, -i or -n. Defaults to true.
git config --global --unset clean.requireForce

# https://git-scm.com/docs/git-config#git-config-colorui
# Use colors in output. Always, never, or auto when writing to terminal. auto is the default since Git 1.8.4.
git config --global --unset color.ui

