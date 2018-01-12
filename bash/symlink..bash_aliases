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
alias mysqlstart='sudo /opt/local/bin/mysqld_safe5 &'
alias mysqlstop='/opt/local/bin/mysqladmin5 -u root -p shutdown'
alias checkStyle='java -jar ~/bin/checkstyle-5.5/checkstyle-5.5-all.jar -c ~/bin/checkstyle-5.5/jhu_checks.xml'
#Node.js testin
alias mocha='./node_modules/mocha/bin/mocha'

alias javacx='javac -Xlint:all'
alias javacxu='javac -Xlint:all -classpath .:/Users/adno4/bin/ant-1.8/junit-4.10.jar'
alias javax='java -ea'
alias javau='java -cp .:/Users/adno4/bin/ant-1.8/junit-4.10.jar org.junit.runner.JUnitCore'
alias javaps='java -agentlib:hprof=cpu=samples'
alias javapt='java -agentlib:hprof=cpu=times'
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

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
  alias stfu="osascript -e 'set volume output muted true'"
  alias pumpitup="osascript -e 'set volume 7'"
  alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"
fi

# Shortcut for cygwinports
if [[ "$OSTYPE" == cygwin ]]; then
  alias cygsetup="cygstart -- $CYG_SETUP -K http://cygwinports.org/ports.gpg"
fi

# School stuff
alias cpNote="rsync -r $NOTE_HOME $caen_ssh:~/Notes/"
alias dlNote="rsync -r $caen_ssh:~/Notes/ $NOTE_HOME "