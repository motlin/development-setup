#!/bin/bash
# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -uo pipefail

# Removing Redundant Git Configuration

# Git's default values for configuration have improved over time. Sometimes bad defaults were improved. Often, new features are set to false at first and flipped to true once stable.

# Git has no way to look up default configuration values, making it hard to know if a configuration is redundant. This script unsets configuration that is no longer necessary assuming you're on a reasonably modern version of git.

# The script is arranged in chronological order of when the good default value was introduced. You can copy and run up to the version of git that you're running, or run the whole thing if you're on the latest version of git.

safe_unset() {
    local key=$1
    local value=$2

    current_value=$(git config --global --get "$key")
    local action=""

    if [ -z "$current_value" ]; then
        action="No action"
        after_value="(not set)"
    elif [ "$current_value" == "$value" ]; then
        git config --global --unset "$key"
        action="Unset"
        after_value="(not set)"
    else
        # The key is set, but not to the specified value
        action="No action"
        after_value="$current_value"
    fi

    printf "%-26s %-12s %-20s %-20s\n" "$key" "$action" "${current_value:-(not set)}" "$after_value"
}

# Print the header
printf "%-26s %-12s %-20s %-20s\n" "Key" "Action" "Value Before" "Value After"
printf "%-26s %-12s %-20s %-20s\n" "--------------------------" "---------" "--------------------" "--------------------"

# < 2.0 clean.requireForce
# A boolean to make git-clean do nothing unless given -f, -i or -n. Defaults to true since ???.
# https://git-scm.com/docs/git-config/#Documentation/git-config.txt-cleanrequireForce
safe_unset clean.requireForce true

# 1.8.4 color.ui
# Use colors in output. Always, never, or auto when writing to terminal.
# https://git-scm.com/docs/git-config/#Documentation/git-config.txt-colorui
safe_unset color.ui auto

# 2.24 core.commitGraph
safe_unset core.commitGraph true

# 2.24 gc.writeCommitGraph
safe_unset gc.writeCommitGraph true

# 2.26 protocol.version
safe_unset protocol.version 2

# Some time between 2.26 and 2.30.0 pack.useSparse
safe_unset pack.useSparse true

# 2.41.0 pack.writeReverseIndex
safe_unset pack.writeReverseIndex true
