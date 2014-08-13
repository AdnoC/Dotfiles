if ! command -v node >/dev/null 2>&1; then
  if [ "$(uname -s)" == "Linux" ]; then
    if [ "$NO_NODEJS_PPA" == "" ]; then
      sudo apt-get install python-software-properties
      sudo apt-add-repository ppa:chris-lea/node.js
      sudo apt-get update
    fi
    sudo apt-get install nodejs
  fi
fi

if command -v npm >/dev/null 2>&1; then
  sudo npm install jshint -g
fi
