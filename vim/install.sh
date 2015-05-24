if ! hasCommand "ctags"; then
  if isOSX; then
    info "Installing ctags from brew"
    brew install ctags-exuberant

  elif isLinux; then
    info "Installing ctags from apt-get"

  elif [ "$OSTYPE" == "cygwin" ]; then
    info "Please install ctags through cygports. Intructions can be found here:"
    info "http://cygwinports.org/"
  fi
fi

if isLinux; then
  info "Installing clang from apt-get"
  sudo apt-get install clang libclang1-3.4 libclang-3.4-dev exuberant-ctags
else
  info "Make sure you install libclang for YouCompleteMe"
fi

# cmake needs to be at least version 2.8.12 to use upstream YouCompleteMe
if ! hasCommand "cmake" || [ "$(echo \"$(cmake --version) 2.8.12 \" | awk '{print $3 " " $4}' | awk -f ~/dotfiles/script/version.awk)" -lt 0]; then
  info "cmake is not high enough version for YouCompleteMe (Must be > 2.8.12)"
  if isLinux; then
    info "Trying to update cmake"
    sudo apt-get install cmake
  fi
fi
# If the new version is high enough, make sure to tell Vim
if hasCommand "cmake" && [ "$(echo \"$(cmake --version) 2.8.12 \" | awk '{print $3 " " $4}' | awk -f ~/dotfiles/script/version.awk)" -ge 0]; then
  info "Using upstream YouCompleteMe"
  # Set a variable to tell Vim that we are using this version
  cat 'export UPSTREAM_YCM=true' >> ~/.bash_profile.local
  export UPSTEAM_YCM=true
else

  info "Using forked YouCompleteMe"
  # Since the new version is high enough, make sure to tell Vim
  cat 'export UPSTREAM_YCM=true' >> ~/.bash_profile.local
  export UPSTEAM_YCM=true
fi

# If the version of vim is too low for YouCompleteMe
if [ $(vim --version | grep -o '7\.[0-9]') -lt '7.4' ]; then
  info "Current version of Vim is too low for YouCompleteMe"
  if isLinux; then
    info "Attempting to update vim using apt-get"
    sudo add-apt-repository ppa:fcwu-tw/ppa
    sudo apt-get update
    sudo apt-get install vim
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
