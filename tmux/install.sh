if ! hasCommand "tmux"; then
  info "Installing tmux"
  if isOSX; then
    brew install tmux
  elif isLinux; then
    if [ "$( echo "$(cat /etc/lsb-release | grep -o -m 1 "[0-9]*\.[0-9]*") 12.04" | awk -f ~/dotfiles/script/version.awk)" -eq 0 ]; then
      sudo add-apt-repository -y ppa:pi-rho/dev
      sudo apt-get update
      sudo apt-get install -y tmux=1.9a-1~ppa1~p
    else
      sudo apt-get -y install tmux
    fi
  fi
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
  info "Cloning tmux plugin manager"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
