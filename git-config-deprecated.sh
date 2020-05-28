#!/bin/bash

# Git deprecated configuration
    # In the past, git has had some poor default configuration that were fixed in later versions.
    # These --unset commands can clean up some configuration that is no longer necessary assuming you're on a reasonably modern version of git.
    # Be careful though, these commands do not check that your configuration is in fact redundant.
    # Check your version of git using `git --version`
    # Move the `exit 0` command to the right spot based on your version

    # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
    set -uxo pipefail

# Pre-2.0
    # clean.requireForce
        # A boolean to make git-clean do nothing unless given -f, -i or -n. Defaults to true since ???.
        # https://git-scm.com/docs/git-config/#Documentation/git-config.txt-cleanrequireForce
        git config --global --unset clean.requireForce
    # color.ui
        # Use colors in output. Always, never, or auto when writing to terminal. auto is the default since Git 1.8.4.
        # https://git-scm.com/docs/git-config/#Documentation/git-config.txt-colorui
        git config --global --unset color.ui
# 2.0
    # push.default
        # https://git-scm.com/docs/git-config/#Documentation/git-config.txt-pushdefault
        # Defines the action git push should take if no refspec is explicitly given.
        # Default changed from 'matching' to 'simple' in 2.0.
        git config --global --unset push.default
# 2.24
    # core.commitGraph
        git config --global --unset core.commitGraph
    # gc.writeCommitGraph
        git config --global --unset gc.writeCommitGraph
# 2.26
    # protocol.version
        git config --global --unset protocol.version

exit 0

# Some future version of git
    # fetch.writeCommitGraph
        git config --global --unset fetch.writeCommitGraph
