if [ -n "$DOTFILES_ROOT" ]; then
  cd "$(dirname "$0")/.."
  DOTFILES_ROOT=$(pwd)
fi

if [ -n "$logFile" ]; then
  logFile="$(pwd)"/bootstrap_log
  touch "$logFile"
fi

hasCommand () {
  command -v "$1" >/dev/null 2>&1 ;
}

isCygwin () {
  [ "$(uname -o)" == "Cygwin" ];
}

isOSX () {
  [ "$(uname -s)" == "Darwin" ];
}

isWSL () {
  [ -f /proc/sys/kernel/osrelease ] && \
    [[ "$(cat /proc/sys/kernel/osrelease)" == *"Microsoft" ]];
}

# I know that the way I'm using this (basically if has apt-get) doesn't match what
# this checks, but whatever.
isLinux () {
  [ "$(uname -s)" == "Linux" ];
}

info () {
  printf "  [ \033[00;34m..\033[0m ] $1\n"
  echo -e "Info: $1\n" >> "$logFile"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 \n"
  echo -e "User: $1\n" >>  "$logFile"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
  echo -e "Success: $1\n" >>  "$logFile"
}

warn () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo -e "Warn: $1\n" >>  "$logFile"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo -e "Fail: $1\n" >>  "$logFile"
  echo ''
  exit
}
