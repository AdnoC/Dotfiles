if ! command -v ctags >/dev/null 2>&1; then
  if [ "$(uname)" == "Darwin" ]; then
    brew install ctags-exuberant
  elif [ "$(uname -s)" == "Linux" ]; then
    if command -v apt-get >/dev/null 2>&1; then
      echo "Installing ctags from apt-get"
      sudo apt-get install exuberant-ctags
    fi
    if command -v apt-get >/dev/null 2>&1; then
      echo "Installing clang from apt-get"
      sudo apt-get install clang libclang1-3.4 libclang-3.4-dev exuberant-ctags
    fi
    # cmake needs to be at least version 2.8.12 to use upstream YouCompleteMe
    if [ "$(echo \"$(cmake --version) 2.8.12 \" | awk '{print $3 " " $4}' | awk -f ~/dotfiles/script/version.awk)" -lt 0]; then
      echo "cmake is not high enough version for YouCompleteMe (Must be > 2.8.12)"
      echo "Trying to update cmake"
      sudo apt-get install cmake
      # If the new version is high enough, make sure to tell Vim
      if [ "$(echo \"$(cmake --version) 2.8.12 \" | awk '{print $3 " " $4}' | awk -f ~/dotfiles/script/version.awk)" -lt 0]; then
        # Set a variable to tell Vim that we are using this version
        cat 'export UPSTREAM_YCM=true' >> ~/.bash_profile.local
        export UPSTEAM_YCM=true
      fi
    else
      # Since the new version is high enough, make sure to tell Vim
      cat 'export UPSTREAM_YCM=true' >> ~/.bash_profile.local
      export UPSTEAM_YCM=true
    fi
  elif [ "$OSTYPE" == "cygwin" ]; then
    echo "Please install ctags through cygports. Intructions can be found here:"
    echo "http://cygwinports.org/"
  fi
fi


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
