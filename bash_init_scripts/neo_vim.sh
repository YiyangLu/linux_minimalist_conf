#!/bin/bash
set -eu
nvim="$HOME/.local/bin/nvim"
nvimurl="https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
mkdir -p "$(dirname "$nvim")"
curl -fL "$nvimurl" -o "$nvim" -z "$nvim"
chmod u+x "$nvim"
mv ~/.config/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim

