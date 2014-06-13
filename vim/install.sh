if ! command -v ctags >/dev/null 2>&1; then
  if [ "$(uname)" == "Darwin" ]; then
    brew install ctags-exuberant
  elif [ "$(uname -s)" == "Linux" ]; then
    if ! command -v apt-get >/dev/null 2>&1; then
      echo "Installing ctags from apt-get"
      sudo apt-get install exuberant-ctags
    fi
  elif [ "$OSTYPE" == "cygwin" ]; then
    echo "Please install ctags through cygports. Intructions can be found here:"
    echo "http://cygwinports.org/"
  fi
fi
