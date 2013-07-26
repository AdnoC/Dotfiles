echo "bash_profile"
for file in ~/.bash_{prompt,aliases,functions}; do
	[ -r "$file" ] && source "$file"
done
unset file

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi 

if [ -f ~/.profile ]; then 
  source ~/.profile
fi 

shopt -s globstar

# colors!
export CLICOLOR=1

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

if [ "$SHELL" = "/bin/bash" ]; then
  #magical new tab to last directory trick
  #source: http://gist.github.com/132456
  function pathed_cd () {
      if [ "$1" == "" ]; then
          cd
      else
          cd "$1"
      fi
      pwd > ~/.cdpath
  }
  alias cd="pathed_cd"
 
  if [ -f ~/.cdpath ]; then
    cd "$(cat ~/.cdpath)"
  fi
fi
