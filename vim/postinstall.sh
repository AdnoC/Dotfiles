# Install plugins
vim +NeoBundleCheck +qall

if [ "$(uname -s)" == "Linux" ] || [ "$(uname)" == "Darwin" ]; then
  # If the version of vim is too low for YouCompleteMe
  if [ $(vim --version | grep -o '7\.[0-9]') -lt '7.4' ]; then
    if [ "$(uname -s)" == "Linux" ]; then
      if command -v apt-get >/dev/null 2>&1; then
        sudo add-apt-repository ppa:fcwu-tw/ppa
        sudo apt-get update
        sudo apt-get install vim
      fi
    fi
  fi

  cd ~/.vim/bundle/YouCompleteMe
  git submodule update --init --recursive
  ./install.sh
  cd -
fi
