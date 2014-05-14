echo "bash_functions"
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

# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@"
}

# Copy w/ progress
cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

eject() {
	sudo umount -f "/Volumes/$@"
}

glfwcc() {
  x86_64-w64-mingw32-g++.exe -static "$@" -L /usr/local/lib -I /usr/local/include/  -lglfw3  -lopengl32 -lgdi32
}
