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


if [ ! -d ~/.vim/vimball ]; then
  if [ ! -d ~/.vim ]; then
    mkdir ~/.vim
  fi
  link_file "$DOTFILES_ROOT"/vim/vimball.sym ~/.vim/vimball
fi

SYNTAX_TARGET="${HOME}/.vim/syntax"
mkdir -p "$SYNTAX_TARGET"
SYNTAX_ROOT="$DOTFILES_ROOT"/vim/syntax
for src in $(find "$SYNTAX_ROOT" -name "*.sym")
do
  if [ ! -f "${SYNTAX_TARGET}/$(basename "${src%.*}")" ]; then
    dst="${SYNTAX_TARGET}/$(basename "${src%.*}")"
    link_file "$src" "$dst"
  fi
done
unset dst
unset SYNTAX_TARGET
unset SYNTAX_ROOT
