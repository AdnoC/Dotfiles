#!/bin/bash
RET=1
if hasCommand "apt-get"; then
  info "  Updating apt-get for you"
  sudo apt-get update
else
  return 1
fi

if ! hasCommand "add-apt-repository"; then
  if [ "$( echo "$(cat /etc/lsb-release | grep -o -m 1 "[0-9]*\.[0-9]*") 14.04" | awk -f ~/dotfiles/script/version.awk)" -lt 0 ]; then
    sudo apt-get -y install python-software-properties
  else
    sudo apt-get -y install software-properties-common
  fi
fi

return 0
