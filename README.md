## Description
A list of my dotfiles. Mainly for self reference and in order to access them
anywhere. Recently upgraded from a simple repo of dotfiles to a symlink based
auto-installing thing of awesomeness. The symlink stuff is based on Zach Holman's
dotfile repo ("holman/dotfiles").

A lot of stuff here was incorporated from other dotfile repositories on github,
I don't take credit for any well written sections of the files here and try to
reference whatever source I got them from when I remember.

A major motivation for moving to a symlink-based system was that it actually let
me see changes to git repos in the prompt without causing lag inside my home
directory. Traditional systems cause your home directory to be a git repo, which
causes it to list every single file that isn't in a different repo when checking
for untracked files.


## Instalation Instructions
    git clone https://github.com/AdnoC/dotfiles.git
    cd dotfiles && bash script/bootstrap
Then just open vim and let it automatically install the plugins.
If you are using a Mac, or the terminal colorscheme isn't applied, go to
[this repo](https://github.com/altercation/solarized) and follow the instructions for whatever
terminal you are using

NOTE: If you do not have ctags installed it will not install the vim plugin 'tagbar'
NOTE: If you do not have phps installed it will not install the vim plugins for
php tagbar
NOTE: If you do not have w3m installed it will not install the vim plugin 'W3m'
