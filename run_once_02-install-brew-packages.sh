#!/bin/bash

set -e

echo "==> Step 2: Brew Packages"

# Ensure brew is in path
if [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew bundle --file="$(chezmoi source-path)/Brewfile"
