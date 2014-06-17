if [ ! -d ~/bin ]; then
  mkdir ~/bin
fi
if [ ! -f ~/bin/tmux ]; then
  chmod +x "$DOTFILES_ROOT"/bin/tmux.sym
  link_file "$DOTFILES_ROOT"/bin/tmux.sym ~/bin/tmux
fi
