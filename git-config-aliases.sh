#!/bin/bash

# Git optional aliases

set -euxo pipefail

# My aliases that aren't too common
git config --global alias.ri 'rebase --interactive --autosquash'
git config --global alias.f 'fetch --all --prune --jobs=8'
git config --global alias.detach 'checkout --detach'
git config --global alias.ss 'status --short'
git config --global alias.m 'mergetool --no-prompt --tool=vimdiff'
git config --global alias.exec '!exec '

# Git log --graph aliases
git config --global alias.gl "log --graph --decorate --date=short --format=format:'%C(yellow)%h%C(reset) %C(cyan)%ad%C(reset)%C(auto)%d%C(reset) %C(normal)%s%C(reset) %C(magenta)%an%C(reset) %C(green)%ar%C(reset)'"
git config --global alias.ga "log --graph --decorate --date=short --format=format:'%C(yellow)%h%C(reset) %C(cyan)%ad%C(reset)%C(auto)%d%C(reset) %C(normal)%s%C(reset) %C(magenta)%an%C(reset) %C(green)%ar%C(reset)' --exclude=refs/remotes/upstream/pr/*/merge --all"
git config --global alias.gb "log --graph --decorate --date=short --format=format:'%C(yellow)%h%C(reset) %C(cyan)%ad%C(reset)%C(auto)%d%C(reset) %C(normal)%s%C(reset) %C(magenta)%an%C(reset) %C(green)%ar%C(reset)' --branches"

# reflog
# Some people alias 'rl' to just 'reflog' without all these options
# https://stackoverflow.com/a/17369548/23572
git config --global alias.rl "reflog @{now} --date=relative --format=format:'%C(yellow)%h%C(reset) %C(cyan)%gd%C(reset) %C(green)%ar%C(reset)%C(auto)%d%C(reset) %C(magenta)%gs%C(reset) %C(normal)%s%C(reset)'"

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
