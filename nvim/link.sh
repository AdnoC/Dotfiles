#!/usr/bin/env bash


NVIM_HOME="${XDG_CONFIG_HOME:=$HOME/.config}/nvim"
# Place neovim config in the right place
mkdir -p "$NVIM_HOME"

link_file "$DOTFILES_ROOT/init.lua" "$NVIM_HOME"/init.lua
for src in $(find "$DOTFILES_ROOT"/nvim/* -maxdepth 0 -type d); do
  relDest="$(basename "$src")"
  dst="$NVIM_HOME/$relDest"

  link_file "$src" "$dst"
done
