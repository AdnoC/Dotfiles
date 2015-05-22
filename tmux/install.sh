if ! command -v tmux >/dev/null 2>&1; then
  if [ "$(uname)" == "Darwin" ]; then
    brew install tmux
  elif [ "$(uname -s)" == "Linux" ]; then
    sudo apt-get install tmux
  fi
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
