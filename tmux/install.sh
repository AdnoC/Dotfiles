if ! hasCommand "tmux"; then
  info "Installing tmux"
  if isOSX; then
    brew install tmux
  elif isLinux; then
    sudo apt-get install tmux
  fi
fi

info "Cloning tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
