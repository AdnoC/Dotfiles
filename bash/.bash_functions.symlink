# vim: ft=sh :
findhosts(){
  nmap -sP -n -oG - "$1"/24 | grep "Up" | awk '{print $2}' -
  echo "To scan those do: nmap $1-254"
  echo "To scan and OS detect those do: sudo nmap -O $1-254"
  echo "To intensly scan one do: sudo nmap -sV -vv -PN $1"
}

#functions
cs(){
  cd "$@" && ls .
}

sdlCompileMulti() {
      g++   -o $@ -g -O2 -I/usr/local/include/SDL2 -I/usr/include/mingw -Dmain=SDL_main -DHAVE_OPENGL -g -lSDL2_test -L/usr/local/lib -lcygwin -lSDL2main -lSDL2 -mwindows -lSDL2_image -std=c++11
}
sdlCompile() {
  if [ ! -z "$1" ]; then
    if [ ! -z "$2" ]; then
      g++  "$1" -o "$2" -g -O2 -I/usr/local/include/SDL2 -I/usr/include/mingw -Dmain=SDL_main -DHAVE_OPENGL -g -lSDL2_test -L/usr/local/lib -lcygwin -lSDL2main -lSDL2 -mwindows -lSDL2_image -std=c++11
    else
      g++  $1 -g -O2 -I/usr/local/include/SDL2 -I/usr/include/mingw -Dmain=SDL_main -DHAVE_OPENGL -g -lSDL2_test -L/usr/local/lib -lcygwin -lSDL2main -lSDL2 -mwindows -lSDL2_image -std=c++11
    fi
  fi
}

# Create a new directory and enter it
md() {
  mkdir -p "$@" && cd "$@"
}

# Copy w/ progress
cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

up()
{
    dir=""
    if [ -z "$1" ]; then
        dir=..
    elif [[ $1 =~ ^[0-9]+$ ]]; then
        x=0
        while [ $x -lt ${1:-1} ]; do
            dir=${dir}../
            x=$(($x+1))
        done
    else
        dir=${PWD%/$1/*}/$1
    fi
    cd "$dir";
}

upstr()
{
    echo "$(up "$1" && pwd)";
}

#dirsize - finds directory sizes and lists them for the current directory
dirsize () {
  du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
  egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
  egrep '^ *[0-9.]*M' /tmp/list
  egrep '^ *[0-9.]*G' /tmp/list
  rm -rf /tmp/list
}

psgrep() {
  if [ ! -z $1 ] ; then
    echo "Grepping for processes matching $1..."
    ps aux | grep $1 | grep -v grep
  else
    echo "!! Need name to grep for"
  fi
}

eject() {
  sudo umount -f "/Volumes/$@"
}
if [ "$OSTYPE" == "cygwin" ]; then
# Wrapper for Tmux to fix on Cygin
  tmux() {
    tmux_running="$(ps -a | grep tmux 2>/dev/null)"
    tmux_tmp="$(ls /tmp | grep tmux)"
    if [[ ! -n $tmux_running ]] && [[ -n $tmux_tmp ]]; then
      rm -rf /tmp/tmux-*
    fi
    $(which tmux) "$@"
  }

  glfwcc() {
    x86_64-w64-mingw32-g++.exe -static "$@" -L /usr/local/lib -I /usr/local/include/  -lglfw3  -lopengl32 -lgdi32
  }

  open_path() {
    explorer.exe /e,`cygpath -w "$@"`
  }
fi

if [ "$(uname)" == "Darwin" ]; then
  # Clear Apple’s System Logs
  dstore_clean() {
    find $@ -type f -name .DS_Store -print0 | xargs -0 rm
  }
fi

# Search all subdirectories for files containing a string
search() {
  grep -Rnis $@ **
}

# Find the address of my raspberry pi
piaddress() {
  IP_ADDR=$(hostname -I | cut -f2 -d' ')
  nmap -sn $IP_ADDR/24 | awk '/^Nmap/{ip=$NF}/80:1F:02:EE:89:1B/{print ip}'
  unset IP_ADDR
}

piEthernetAddress() {
  IP_ADDR=$(hostname -I | cut -f2 -d' ')
  nmap -sn $IP_ADDR/24 | awk '/^Nmap/{ip=$NF}/b8:27:eb:96:74:59/{print ip}'
  unset IP_ADDR
}


# Change colorscheme
solChange() {
  if [ $TERM_COLOR = "light" ]; then
    source ~/sol.dark
  else
    source ~/sol.light
  fi
  source ~/.bash_prompt
  source ~/.bash_exports
}
