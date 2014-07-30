## Description
Just copying vim/.vimrc/symlink to ~/.vimrc should get vim running. A lot of the other stuff is
useful though.
Installing the included font should be strongly considered, as the font is awesome and has powerline
symbols patched into it.

# Additional Info
FZF is a fuzzy file searcher. Press Ctrl-t to open the file search. It can be used in the middle of
typing commands to insert file names further down the directory tree.

In .gitconfig, you should replace the name and email with your own.
.gitconfig lets you use shortcuts for many git commands, e.g. 'git co' is the same as 'git checkout'


## Instalation Instructions
    git clone https://github.com/AdnoC/dotfiles.git
    cd dotfiles
    git co transition
    bash script/bootstrap
Then just open vim and let it automatically install the plugins.
Also, you may have to install the included font in order for vim-airline and powerline symbols to
display.

NOTE: If you do not have ctags installed it will not install the vim plugin 'tagbar'
NOTE: If you do not have phps installed it will not install the vim plugins for
php tagbar
NOTE: If you do not have w3m installed it will not install the vim plugin 'W3m'
