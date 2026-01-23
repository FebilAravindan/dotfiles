#!/bin/bash

set -e

echo "==> Step 5: NPM Global Packages"

# Ensure brew is in path
if [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Source asdf to get node/npm
. $(brew --prefix asdf)/libexec/asdf.sh

# Install global packages for LSP support
echo "Installing npm global packages..."
npm i -g @tailwindcss/language-server
npm i -g typescript-language-server
npm i -g typescript
npm i -g vscode-langservers-extracted  # HTML, CSS, JSON, ESLint LSPs
npm i -g @fsouza/prettierd             # Prettier daemon for faster formatting
npm i -g bash-language-server

echo "NPM globals installed successfully"
