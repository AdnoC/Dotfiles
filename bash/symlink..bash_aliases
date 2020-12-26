# vim: ft=sh :
#aliases

#Ensure that ls always shows color
if [[ "$OSTYPE" == darwin* ]]; then
	alias ls="command ls -GAsF"
else
	alias ls=" command ls --color -AsF"
fi
alias cd..="cd .."
alias lsl="ls -1 -A -s -F"

alias fn='find . -name'
# Allow the use of sudo with aliases.
alias sudo='sudo '
alias path='echo -e ${PATH//:/\\n}'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# ATM WSL hasn't implemented the timer_create function.
# This is a workaround
if [ -n $IN_WSL ]; then
  alias pandoc='pandoc +RTS -V0 -RTS'
fi

# Do these things if this is a mac.
if [[ "$OSTYPE" == darwin* ]]; then
# Empty the Trash on all mounted volumes and the main HDD
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Hide/show all desktop icons (useful when presenting)
  alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
  alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
fi

# Shortcut for cygwinports
if [[ "$OSTYPE" == cygwin ]]; then
  alias cygsetup="cygstart -- $CYG_SETUP -K http://cygwinports.org/ports.gpg"
fi
