if ! hasCommand "node"; then
  if isLinux && hasCommand "apt-get"; then
    if ! apt-cache search nodejs | grep "nodejs -" >/dev/null 2>&1; then
      sudo apt-get -y install python-software-properties
      sudo apt-add-repository -y ppa:chris-lea/node.js
      sudo apt-get update
    fi
    info "Installing nodejs from apt-get"
    sudo apt-get -y install nodejs
  fi
fi

if hasCommand "npm"; then
  info "Installing jshint"
  sudo npm install jshint -g
fi

