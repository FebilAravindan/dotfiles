#!/bin/bash

set -e

echo "==> Step 6: Build Helix Editor"

HELIX_DIR="$HOME/DevCraft/helix"

# Ensure brew is in path
if [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Source asdf to get cargo
. $(brew --prefix asdf)/libexec/asdf.sh
asdf reshim rust

# Create DevCraft directory if needed
mkdir -p "$HOME/DevCraft"

# Clone helix if not exists
if [ ! -d "$HELIX_DIR" ]; then
    echo "Cloning Helix..."
    git clone https://github.com/helix-editor/helix "$HELIX_DIR"
fi

cd "$HELIX_DIR"

# Update to latest
git pull

# Build release
echo "Building Helix (this may take a few minutes)..."
cargo build --release

# Setup binary symlink
mkdir -p "$HOME/.local/bin"
ln -sf "$HELIX_DIR/target/release/hx" "$HOME/.local/bin/hx"

# Setup runtime symlink
mkdir -p "$HOME/.config/helix"
ln -sf "$HELIX_DIR/runtime" "$HOME/.config/helix/runtime"

echo "Helix installed successfully!"
echo "Run 'hx --health' to verify"
