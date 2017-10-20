# vim: ft=sh :
if [[ -v _BP_SOURCED ]] && [ "$_BP_SOURCED" -ge "$SHLVL" ]; then
  return
fi
export _BP_SOURCED=$SHLVL
set -o vi

# '.' = run     '$_' = the last arg of the previous command
test -f ~/.bashrc && . $_

test -f ~/.profile && . $_

export TERM_COLOR='dark'

test -f ~/.bash_prompt && . $_

test -f ~/.git-completion.bash && . $_

# Fix auto-complete when using a sudo command
complete -cf sudo

# Don't stop terminal output due to Ctrl+s
# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

shopt -s globstar
# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null
done

#use extra globing features. See man bash, search extglob.
shopt -s extglob
#include .files when globbing.
shopt -s dotglob
#When a glob expands to nothing, make it an empty string instead of the literal characters.
#shopt -s nullglob
# fix spelling errors for cd, only in interactive shell
shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set a default umask
umask 0022

# colors!
export CLICOLOR=1

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# If we kept note of the directory we were at when we last closed the terminal
# and we're starting in $HOME, go to that directory.
if [ -s ~/.lastdirectory ] && [ "$(pwd)" == "$HOME" ]; then
  cd "$(cat ~/.lastdirectory)"
fi

test -f ~/.bash_profile.local && . $_

# Let me source the profile again manually if I want to
unset _BRC_SOURCED
unset _BP_SOURCED
