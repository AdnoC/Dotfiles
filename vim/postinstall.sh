# Install plugins
vim +NeoBundleCheck +qall

# No longer needed because I made a fork that uses the correct commit of YCM
#echo "Installing YouCompleteMe"
#mkdir -p ~/.vim/bundle/YouCompleteMe
#rm -rf ~/.vim/bundle/YouCompleteMe/*
#rm -rf ~/.vim/bundle/YouCompleteMe/.*
#pushd .
#cd ~/.vim/bundle/YouCompleteMe
#git init
#git remote add origin https://git::@github.com/Valloric/YouCompleteMe
#git pull origin master
#git reset --hard 83fb8b8a15a734e8971245ad48fb5c11c67e8e18k
#git submodule update --init --recursive

##cd ~/.vim/bundle/YouCompleteMe
##git submodule update --init --recursive
##./install.sh
##cd -
