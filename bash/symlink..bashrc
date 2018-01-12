# vim: ft=sh :
# If not running interactively, don't do anything
if [[ -v _BRC_SOURCED ]] && [ "$_BRC_SOURCED" -ge "$SHLVL" ]; then
  return
fi
export _BRC_SOURCED=$SHLVL
[ -z "$PS1" ] && return
if [ ${#BASH_SOURCE[@]} -gt 2 ]; then
  return
fi

#Run for non-login shells
for file in ~/.bash_{exports,functions,aliases}; do
  test -f $file && . $_
done

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

unset file
test -f ~/.fzf.bash && . $_

# If we are running interactively but haven't sourced .bash_profile yet
# (AKA if this is the first file sourced), source it.
if [ -z "$_BP_SOURCED" ]; then
  source ~/.bash_profile
fi