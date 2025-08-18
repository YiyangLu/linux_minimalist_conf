#!/bin/bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -C ~/.local/bin -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz

mv ~/.config/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim

