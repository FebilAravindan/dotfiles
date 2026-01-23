#!/bin/bash

set -e

echo "==> Step 4: asdf Plugins & Versions"

# Ensure brew is in path
if [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Source asdf
. $(brew --prefix asdf)/libexec/asdf.sh

# Add plugins (|| true to not fail if already exists)
echo "Adding asdf plugins..."
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
asdf plugin add rust https://github.com/code-lever/asdf-rust.git || true
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git || true
asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git || true

# Install versions from .tool-versions
if [ -f "$HOME/.tool-versions" ]; then
    echo "Installing versions from .tool-versions..."
    cd "$HOME"
    asdf install
else
    echo "No .tool-versions found, installing latest versions..."
    
    # Install latest nodejs
    asdf install nodejs latest
    asdf global nodejs latest
    
    # Install rust
    asdf install rust latest
    asdf global rust latest
fi

# Reshim to make binaries available
asdf reshim
