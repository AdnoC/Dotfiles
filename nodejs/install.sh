if ! hasCommand "node"; then
  if isLinux; then
    if [ "$( echo "$(cat /etc/lsb-release | grep -o -m 1 "[0-9]*\.[0-9]*") 12.04" | awk -f ~/dotfiles/script/version.awk)" -eq 0 ]; then
      sudo apt-get -y install clang-3.4 libssl-dev curl 
      CC=/usr/bin/clang-3.4
      CXX=/usr/bin/clang-3.4
      export CC
      export CXX
      curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
    # If there is no nodejs in the apt-get repos, add one
    elif ! apt-cache search nodejs | grep "nodejs -" >/dev/null 2>&1; then
      sudo apt-get -y install python-software-properties
      sudo apt-add-repository -y ppa:chris-lea/node.js
      sudo apt-get update
    fi
    info "Installing nodejs from apt-get"
    sudo apt-get -y install nodejs
  fi
fi

if ! hasCommand "npm"; then
  if isLinux; then
    info "Installing npm"
    sudo apt-get -y install npm
  fi
fi

if hasCommand "npm"; then
  if hasCommand "sudo"; then
    info "Installing node packages"
    sudo npm install -g jshint
    sudo npm install -g tern
    sudo npm install -g jsctags
  else
    info "Installing node packages"
    npm install -g jshint
    npm install -g tern
    npm install -g jsctags
  fi
fi

