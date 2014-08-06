# Mac comes with bash 3, so lets install bash 4
if [ "$(uname)" == "Darwin" ]; then
  brew install bash
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/bash
fi

source ~/.bash_profile &
