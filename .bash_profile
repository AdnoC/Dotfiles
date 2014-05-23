for file in ~/.bash_{prompt,aliases,functions}; do
	[ -r "$file" ] && source "$file"
done
unset file

if [ "$RANPROFILE" == "" ]; then
  export RANPROFILE="true";
  if [ -f ~/.bashrc ]; then
    source ~/.bashrc
  fi 
fi


if [ -f ~/.profile ]; then 
  source ~/.profile
fi 

shopt -s globstar
# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null
done

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
