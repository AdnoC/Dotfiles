# Install plugins
vim +qall
# Fix line endings for jcommenter
sed -e "s///g" ~/.vim/bundle/jcommenter.vim/plugin/jcommenter.vim > tmp
mv tmp ~/.vim/bundle/jcommenter.vim/plugin/jcommenter.vim
