#!/usr/bin/env bash

curDir="$(pwd)"
symlinkRelPath() {
  hardFilePath="$1"
  relSymPath="${hardFilePath#$curDir}"
  hardName="$(basename "$relSymPath")"
  fixedName="${hardName#symlink.}"
  relDirPath="$(dirname "$relSymPath")/"
  relPath="${relDirPath#/*/}"

  echo "$relPath$fixedName" # Not prefixed with a '/'
}

WIN_VIM_HOME="$HOME"/WinUser/AppData/Local/nvim

print_copy_info() {
  echo "copied $1 to $2"
}

print_copy_info ~/.vimrc ~/WinUser/AppData/Local/nvim/init.vim
cp ~/.vimrc ~/WinUser/AppData/Local/nvim/init.vim

for src in $(find "$(pwd)" -name 'symlink.*'); do
  relDest="$(symlinkRelPath "$src")"
  if [[ $relDest == .vim/* ]]; then
    relDest="${relDest#.vim/}"
  fi
  dst="$WIN_VIM_HOME/$relDest"

  mkdir -p "$(dirname "$dst")"

  print_copy_info "$src" "$dst"
  cp -rT "$src" "$dst"
done
