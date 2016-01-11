if ! hasCommand "vim"; then
  if isLinux; then
    sudo apt-get -y install vim
  fi
fi

if ! hasCommand "ctags"; then
  if isOSX; then
    info "Installing ctags from brew"
    brew install ctags-exuberant

  elif isLinux; then
    info "Installing ctags from apt-get"

  elif isCygwin; then
    warn "Please install ctags through cygports. Intructions can be found here: \
      http://cygwinports.org/"
  fi
fi

if ! hasCommand "php"; then
  if isOSX; then
    warn "Please install php"
  elif isLinux; then
    info "Installing php"
    sudo apt-get -y install php
  elif isCygwin; then
    warn "Please install php"
  fi
fi

if isLinux; then
  info "Installing clang from apt-get"
  sudo apt-get -y install clang libclang1-3.4 libclang-3.4-dev exuberant-ctags
else
  info "Make sure you install libclang for YouCompleteMe"
fi

# cmake needs to be at least version 2.8.12 to use upstream YouCompleteMe
if ! hasCommand "cmake" || [ "$(echo "$(cmake --version) 2.8.12 " | awk '{print $3 " " $4}' | awk -f ~/dotfiles/script/version.awk)" -lt 0 ]; then
  info "cmake is not high enough version for YouCompleteMe (Must be > 2.8.12)"
  if isLinux; then
    info "Trying to update cmake"
    sudo apt-get -y install build-essential cmake python-dev
  fi
fi
# If the new version is high enough, make sure to tell Vim
if hasCommand "cmake" && [ "$(echo "$(cmake --version) 2.8.12 " | awk '{print $3 " " $4}' | awk -f ~/dotfiles/script/version.awk)" -ge 0 ]; then
  info "Using upstream YouCompleteMe"
  # Make sure local preference file exists
  [ -f "~/.bash_profile.local" ] || touch ~/.bash_profile.local
  # Set a variable to tell Vim that we are using this version
  echo 'export UPSTREAM_YCM=true' > ~/.bash_profile.local
  export UPSTEAM_YCM=true
else

  info "Using forked YouCompleteMe"
  # Make sure local preference file exists
  [ -f "~/.bash_profile.local" ] || touch ~/.bash_profile.local
  # Since the new version is high enough, make sure to tell Vim
  echo 'export UPSTREAM_YCM=false' > ~/.bash_profile.local
  export UPSTEAM_YCM=false
fi

# If the version of vim is too low for YouCompleteMe
if [ "$(echo "$(vim --version | grep -o '7\.[0-9]') 7.4" | awk -f ~/dotfiles/script/version.awk)" -lt 0 ]; then
  info "Current version of Vim is too low for YouCompleteMe"
  if isLinux; then
    info "Attempting to update vim using apt-get"
    sudo add-apt-repository -y ppa:fcwu-tw/ppa
    sudo apt-get update
    sudo apt-get -y install vim
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
