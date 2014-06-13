if [ ! -d ~/.ssh ]; then
  mkdir ~/.ssh
fi
link_file ~/.ssh/rc "$DOTFILES_ROOT"/ssh/rc.sym
