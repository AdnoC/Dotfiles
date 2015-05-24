#!/bin/bash
if ! hasCommand "apt-get"; then
  info "  Updating apt-get for you"
  sudo apt-get update
  return 0
else
  return 1
fi
