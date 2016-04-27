# Install plugins
if hasCommand "nvim"; then
  nvim +PlugInstall +qall
else
  vim +PlugInstall +qall
fi
