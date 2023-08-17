#!/usr/bin/env bash
# postCreate can run any tasks that require the container to be up and running.
#
# devcontainer lifecycle commands specification
# https://code.visualstudio.com/docs/remote/devcontainerjson-reference#_lifecycle-scripts

set -eo pipefail

# Setup semgrep rules repository
if [ ! -d "/workspaces/platform-tools" ]; then
    git clone git@github.com:freetrade-io/platform-tools.git /workspaces/platform-tools
else
    cd /workspaces/platform-tools
    git pull --rebase
fi
