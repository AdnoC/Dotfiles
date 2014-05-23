#aliases

#Ensure that ls always shows color
if [[ "$OSTYPE" =~ ^darwin ]]; then
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
alias sudo='sudo '
alias path='echo -e ${PATH//:/\\n}'
#My habbit is to just type "vi"
alias vi='vim'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
alias dstore-clean='find . -type f -name .DS_Store -print0 | xargs -0 rm'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 7'"
alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"

alias restartService="service memcached restart && service mysql restart && service apache2 restart"
alias drb="drush -l bz.localhost"

