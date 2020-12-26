# vim: ft=sh :
# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

test -f ~/.fzf.bash && . $_

test -f ~/.bashrc.local && . $_
