if [ ! -f ~/.ssh/rc ] && [ -z "$LINK_SSH_RC"]; then
  if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
  fi
  link_file "$DOTFILES_ROOT"/ssh/rc.sym ~/.ssh/rc
fi
