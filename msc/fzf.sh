# NOTE: Make this work for everything later, when I'm not as sleepy.
#if [ "$(uname)" == "Darwin" ]; then
  #brew install ctags-exuberant
#elif [ "$(uname -s)" == "Linux" ]; then
  #if ! command -v apt-get >/dev/null 2>&1; then
    #sudo apt-get install exuberant-ctags
  #fi
#elif [ "$OSTYPE" == "cygwin" ]; then
  #echo "Please install ctags through cygports. Intructions can be found here:"
  #echo "http://cygwinports.org/"
#fi

if [ "$(uname -s)" == "Linux" ]; then
  sudo apt-get install libncurses-ruby

fi
git clone https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
