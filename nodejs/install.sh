if ! hasCommand "node"; then
  if isLinux && hasCommand "apt-get"; then
    if [ "$NO_NODEJS_PPA" == "" ]; then
      sudo apt-get install python-software-properties
      sudo apt-add-repository ppa:chris-lea/node.js
      sudo apt-get update
    fi
    info "Installing nodejs from apt-get"
    sudo apt-get install nodejs
  fi
fi

if hasCommand "npm"; then
  info "Installing jshint"
  sudo npm install jshint -g
fi
