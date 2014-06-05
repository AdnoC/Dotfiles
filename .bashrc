#Run for non-login shells
for file in ~/.bash_{aliases,functions,exports}; do
	[ -r "$file" ] && source "$file"
done
unset file
