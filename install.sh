if ! command -v tmux >/dev/null 2>&1; then
  if [ "$(uname -s)" == "Linux" ]; then
    sudo apt-get install tmux
  fi
fi
