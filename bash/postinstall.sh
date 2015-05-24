# Mac comes (or came) with bash 3, so lets install bash 4
if isOSX; then
  brew install bash
  info '/usr/local/bin/bash' | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/bash
fi

source ~/.bash_profile &
