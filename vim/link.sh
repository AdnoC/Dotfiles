#!/usr/bin/env bash


NVIM_HOME="${XDG_CONFIG_HOME:=$HOME/.config}/nvim"
# Place neovim config in the right place
mkdir -p "$NVIM_HOME"

link_file "$(readlink "$HOME"/.vimrc)" "$NVIM_HOME"/init.vim
for src in $(find "$DOTFILES_ROOT"/vim -name 'symlink.*'); do
  relDest="$(symlinkRelPath "$src")"
  if [[ $relDest == .vim/* ]]; then
    relDest="${relDest#.vim/}"
  fi
  dst="$NVIM_HOME/$relDest"

  link_file "$src" "$dst"
done
