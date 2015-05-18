if [ ! -f ~/.ssh/rc ]; then
  if [ ! -d ~/.ssh ] && [ -z "$LINK_SSH_RC"]; then
    mkdir ~/.ssh
  fi
  link_file "$DOTFILES_ROOT"/ssh/rc.sym ~/.ssh/rc
fi
