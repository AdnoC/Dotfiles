#Run for non-interactive shells
if [ -f ~/.bash_exports ]; then
  source ~/.bash_exports
fi 

if [ "$RANPROFILE" == "" ]; then
  export RANPROFILE="true";
  if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
  fi 
fi


