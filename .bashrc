#Run for non-login shells
for file in ~/.bash_{exports,functions,aliases}; do
	[ -r "$file" ] && source "$file"
done
unset file
