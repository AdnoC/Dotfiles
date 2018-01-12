#!/usr/bin/env bash

# Place neovim config in the right place
mkdir -p "${XDG_CONFIG_HOME:=~/.config}/nvim"

for src in $(find "$DOTFILES_ROOT"/vim -name 'symlink.*'); do
  relDest="$(symlinkRelPath "$src")"
  if [[ $relDest == .vim/* ]]; then
    relDest="${relDest#.vim/}"
  fi
  dst="$XDG_CONFIG_HOME/$relDest"

  link_file "$src" "$dst"
done
