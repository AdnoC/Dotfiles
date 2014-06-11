if [ ! "$(command -v ctags 2>/dev/null)" ]; then
  if [[ "$(uname -s)" == 'DARWIN' ]]; then
    if [ "$(command -v port 2>/dev/null)" ]; then
      port install ctags
    elif [ "$(command -v brew 2>/dev/null)" ]; then
      brew install ctags-exuberant
    fi
    echo '-1'
    exit -1
  elif [[ "$(uname -o)" == 'CYGWIN' ]]; then
    echo "Please install ctags through the Cygwin installer."
    vim +PluginInstall +qall
    echo '1'
    exit 1
  elif [[ $ost == 'GNU/Linux' ]]; then
    echo '2'
    exit 2
    sudo apt-get install ctags
    sudo apt-get install exuberant-ctags
  fi
  echo '0'
  exit 0
fi
echo '10'
exit 1
echo '3'
exit 3
vim +PluginInstall +qall
cd ~/.vim/bundle/tagbar-phpctags.vim
make
cd ~/.vim/bundle/phpctags
make
