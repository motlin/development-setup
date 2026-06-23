#!/bin/bash

# Git optional aliases

set -euxo pipefail

# My aliases that aren't too common
git config --global alias.ri 'rebase --interactive --autosquash --rebase-merges'
git config --global alias.f 'fetch --all --prune --jobs=8'
git config --global alias.detach 'checkout --detach'
git config --global alias.ss 'status --short'
git config --global alias.m 'mergetool --no-prompt --tool=vimdiff'
git config --global alias.exec '!exec '

# Git log --graph aliases
# Several variants of `git log --graph --oneline` with richer formatting:
#   l        for specified branches or HEAD, e.g. `git l main`
#   laa      for all refs
#   la       like laa but filters notes, stash, dependabot, and pull-request refs
#   decorate like la, but --simplify-by-decoration
# Format: decorate prefix on its own line, dim abbreviated hash, notes, subject
# truncated 50 from the right edge, author name (15), author date, relative date.
git config --global alias.l "log --graph --decorate --date=short --format=format:'%C(auto)%(decorate:prefix=👇 ,suffix=%n,tag=,separator= )%C(reset)%C(dim)%h%C(reset) %N%-C()%C(normal)%<|(-50,trunc)%s%C(reset) %C(brightmagenta)%<(15,trunc)%an%C(reset) %C(brightblue)%ad%C(reset) %C(brightcyan)%ar%C(reset)'"
git config --global alias.laa "l --all"
# The exclude list is personal; tune the pr/dependabot/notes/retype refs to taste.
git config --global alias.la "l --exclude=refs/prefetch/* --exclude=refs/remotes/origin/pr/* --exclude=refs/remotes/upstream/pr/* --exclude=refs/remotes/origin/dependabot/* --exclude=refs/notes/tests/* --exclude=refs/notes/commits --exclude=refs/stash --exclude=refs/remotes/origin/retype --all"
git config --global alias.decorate "la --simplify-by-decoration"

# reflog
# Some people alias 'rl' to just 'reflog' without all these options
# https://stackoverflow.com/a/17369548/23572
git config --global alias.rl "reflog @{now} --date=relative --format=format:'%C(brightyellow)%h%C(reset) %C(brightblue)%gd%C(reset) %C(brightcyan)%cr%C(reset)%C(auto)%d%C(reset) %C(brightmagenta)%gs%C(reset) %C(normal)%s%C(reset)'"

# https://gist.github.com/DuaelFr/5663854
git config --global alias.who 'shortlog --summary --numbered --email --no-merges'
git config --global alias.ignore 'update-index --assume-unchanged'
git config --global alias.unignore 'update-index --no-assume-unchanged'
git config --global alias.ignored "!git ls-files -v | grep '^h'"

# repository root directory
# https://stackoverflow.com/a/957978/23572
git config --global alias.root 'rev-parse --show-toplevel'

# initial commit(s)
# https://stackoverflow.com/a/1007545/23572
git config --global alias.first 'rev-list --max-parents=0 HEAD'

# Aggresive optimizations
# https://github.com/GitAlias/gitalias/blob/master/gitalias.txt
git config --global alias.pruner '!git prune --expire=now && git reflog expire --expire-unreachable=now --rewrite --all'
git config --global alias.repacker 'repack -a -d -f --depth=300 --window=300 --window-memory=1g'
git config --global alias.optimize '!git gc --aggressive && git pruner && git repacker && git prune-packed'

# Show most recent commit on each branch that isn't pushed
# https://stackoverflow.com/a/3338774/23572
git config --global alias.unpushed 'log --branches --not --remotes --simplify-by-decoration --decorate --oneline'
