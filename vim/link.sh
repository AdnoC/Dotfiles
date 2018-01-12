#!/usr/bin/env bash

# Place neovim config in the right place
mkdir -p "${XDG_CONFIG_HOME:=~/.config}/nvim"
link_file "$DOTFILES_ROOT/vim/symlink..vimrc" "$XDG_CONFIG_HOME/nvim/init.vim"
link_file "$DOTFILES_ROOT/vim/symlink..vimrc_plugin" "$XDG_CONFIG_HOME/nvim/.vimrc_plugin"
