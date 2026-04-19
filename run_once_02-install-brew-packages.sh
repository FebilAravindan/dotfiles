#!/bin/bash

set -e

echo "==> Step 2: Brew Packages"

# Ensure brew is in path
if [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

<<<<<<< Updated upstream
=======
# Use CHEZMOI_SOURCE_DIR which is set by chezmoi when running scripts
>>>>>>> Stashed changes
brew bundle --file="${CHEZMOI_SOURCE_DIR}/Brewfile"
