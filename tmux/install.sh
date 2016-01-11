if ! hasCommand "tmux"; then
  info "Installing tmux"
  if isOSX; then
    brew install tmux
  elif isLinux; then
    sudo apt-get -y install tmux
  fi
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
  info "Cloning tmux plugin manager"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
