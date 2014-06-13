#!/bin/bash
if ! command -v apt-get >/dev/null 2>&1
then
  echo "  Updating apt-get for you"
  sudo apt-get update
  return 0
else
  return 1
fi
