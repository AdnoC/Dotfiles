#!/usr/bin/env bash

# Place neovim config in the right place
mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}/nvim"

link_file "$(readlink "$HOME"/.vimrc)" "$XDG_CONFIG_HOME"/nvim/init.vim
for src in $(find "$DOTFILES_ROOT"/vim -name 'symlink.*'); do
  relDest="$(symlinkRelPath "$src")"
  if [[ $relDest == .vim/* ]]; then
    relDest="${relDest#.vim/}"
  fi
  dst="$XDG_CONFIG_HOME/$relDest"

  link_file "$src" "$dst"
done
