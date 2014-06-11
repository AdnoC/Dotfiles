if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.profile ]; then
  source ~/.profile
fi

if [ -f ~/sol.dark ]; then
  source ~/sol.dark
fi

if [ -f ~/.bash_prompt ]; then
  source ~/.bash_prompt
fi

shopt -s globstar
# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null
done

# Set a default umask
umask 0022

# colors!
export CLICOLOR=1

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# If we are using bash and have not already created this function (cuases crashes)
if [ "$SHELL" = "/bin/bash" ] && [ "$(type -t pathed_cd)" != "function" ]; then
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

if [ -f ~/.bash_profile.local ]; then
  source ~/.bash_profile.local
fi
