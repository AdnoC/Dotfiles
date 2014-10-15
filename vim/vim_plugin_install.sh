#if has('gui_win32')
  #let s:vimDirectory=expand("$HOME/vimfiles")
#else
  #let s:vimDirectory=expand("$HOME/.vim")
#endif
#let s:vimDirectoryPart=expand(s:vimDirectory . "/")


        #if has('gui_win32')
          #silent exec "!mkdir " . shellescape(s:vimDirectoryPart . "bundle")
        #else
          #silent exec "!mkdir -p " . (s:vimDirectoryPart . "bundle")
        #endif
git clone git@github.com:Shougo/neobundle.vim
git clone --recursive git@github.com:Shougo/vimproc.vim
cd vimproc.vim
make -f make_unix.mak
cd ..
    #"" Games:
git clone --recursive git@github.com:vim-scripts/TeTrIs.vim
    #""" Git:
    #" So that gitv can work
    git clone --recursive git@github.com:tpope/vim-fugitive
    git clone --recursive git@github.com:gregsexton/gitv
    #" Using both!?!?
    git clone --recursive git@github.com:airblade/vim-gitgutter
    git clone --recursive git@github.com:mhinz/vim-signify
    #""" Auto Formatting:
    #""" Syntax:
    git clone --recursive git@github.com:LaTeX-Box-Team/LaTeX-Box
    git clone --recursive git@github.com:elzr/vim-json
    git clone --recursive git@github.com:groenewege/vim-less
    git clone --recursive git@github.com:jaxbot/semantic-highlight.vim
    git clone --recursive git@github.com:scrooloose/syntastic
    git clone --recursive git@github.com:kien/rainbow_parentheses.vim
    git clone --recursive git@github.com:sheerun/vim-polyglot
    #" Highlights matching HTML tags
    git clone --recursive git@github.com:Valloric/MatchTagAlways
    #" Auto-close HTML tags
    git clone --recursive git@github.com:vim-scripts/HTML-AutoCloseTag
    git clone --recursive git@github.com:Yggdroot/indentLine
    git clone --recursive git@github.com:spf13/PIV
    #" YouCompleteMe only works on Linux/Mac and if vim is version > 7.3.584
    #" Use supertab if YCM won't work
    #if (has('win32') || has('win32unix')) || v:version < 704
      git clone --recursive git@github.com:ervandew/supertab
    #else
      #" This won't work because it times out while loading all the submodules.
      #" It is handled in postinstall though
      #NeoBundle 'Valloric/YouCompleteMe', {
        #\ 'build' : {
          #\ 'unix' : "./install.sh",
          #\ 'mac' : "./install.sh",
        #\ }
      #\ }
    #endif
    git clone --recursive git@github.com:JLimperg/jcommenter.vim
    git clone --recursive git@github.com:heavenshell/vim-jsdoc
    git clone --recursive git@github.com:jelera/vim-javascript-syntax
    git clone --recursive git@github.com:davetron5000/javax-xml-javadoc-vim
    git clone --recursive git@github.com:davetron5000/javax-javadoc-vim
    git clone --recursive git@github.com:davetron5000/java-javadoc-vim
    git clone --recursive git@github.com:vim-scripts/csv.vim
    #" Python autocomplete
    #"NeoBundle 'davidhalter/jedi-vim'
    #""" Tools:
    git clone --recursive git@github.com:scrooloose/nerdcommenter
    git clone --recursive git@github.com:scrooloose/nerdtree
    git clone --recursive git@github.com:sjl/gundo.vim
    git clone --recursive git@github.com:kien/ctrlp.vim
    git clone --recursive git@github.com:szw/vim-ctrlspace
    git clone --recursive git@github.com:kana/vim-operator-user
    git clone --recursive git@github.com:kana/vim-textobj-user
    #" Allows for things like 'cs2a([' to change ((*)) to [(*)]
    git clone --recursive git@github.com:osyo-manga/vim-textobj-multiblock
    #" Allows for text objects to be between any specified char
    git clone --recursive git@github.com:thinca/vim-textobj-between
    #" Allows for the use of 'b' as a text objext of any [('"<
    git clone --recursive git@github.com:rhysd/vim-textobj-anyblock
    #" Allows text objects to only exist on one side of the carot
    git clone --recursive git@github.com:tommcdo/vim-ninja-feet
    git clone --recursive git@github.com:kana/vim-operator-replace
    git clone --recursive git@github.com:coderifous/textobj-word-column.vim
    git clone --recursive git@github.com:kana/vim-textobj-indent
    git clone --recursive git@github.com:kana/vim-textobj-fold
    git clone --recursive git@github.com:glts/vim-textobj-comment
    #""" Looks:
    git clone --recursive git@github.com:junegunn/limelight.vim
    git clone --recursive git@github.com:bling/vim-airline
    git clone --recursive git@github.com:bling/vim-bufferline
    git clone --recursive git@github.com:altercation/vim-colors-solarized
    git clone --recursive git@github.com:edkolev/promptline.vim
    #""" Movement:
    git clone --recursive git@github.com:Lokaltog/vim-easymotion
    git clone --recursive git@github.com:wikitopian/hardmode

    git clone --recursive git@github.com:othree/html5.vim
    git clone --recursive git@github.com:rhysd/vim-operator-surround
    git clone --recursive git@github.com:tpope/vim-abolish
    git clone --recursive git@github.com:tpope/vim-repeat
    git clone --recursive git@github.com:tpope/vim-endwise
    git clone --recursive git@github.com:thinca/vim-ref
    #" matchit breaks [] jumping. Only use it when 100% useful
    git clone --recursive git@github.com:edsono/vim-matchit


    #""" Tagbar:
    #" Ctags are a dependancy of tagbar
    #if executable('ctags')
      git clone --recursive git@github.com:majutsushi/tagbar
      #NeoBundle 'vim-php/phpctags', {
        #\ 'depends' : 'tagbar',
        #\ 'build' : {
          #\ 'cygwin' : 'make -f Makefile',
          #\ 'unix' : 'make -f Makefile',
          #\ 'mac' : 'make -f Makefile'
        #\ }}
      #NeoBundleLazy 'vim-php/tagbar-phpctags.vim', {
        #\ 'depends' : 'phpctags',
        #\ 'build' : {
          #\ 'cygwin' : 'make -f Makefile',
          #\ 'unix' : 'make -f Makefile',
          #\ 'mac' : 'make -f Makefile'
        #\ }}
    #else
      #if iCanHazNeobundle == 0
        #echo 'Cannot find ctags. Not installing tagbar.'
      #endif
    #endif
    #if executable('node')
      #NeoBundleLazy 'marijnh/tern_for_vim' , {
        #\ 'build' : {
          #\ 'cygwin' : 'npm install',
          #\ 'unix' : 'sudo npm install',
          #\ 'mac' : 'sudo npm install',
          #\ }
        #\ }
      #" Install jsctags. Don't add it to the rtp since it isn't a vim plugin
      ##NeoBundleFetch 'ramitos/jsctags' , {
        #\ 'build' : {
          #\ 'cygwin' : 'npm install --update',
          #\ 'unix' : 'sudo npm install --update',
          #\ 'mac' : 'sudo npm install --update',
          #\ }
        #\ }
      #"NeoBundle 'faceleg/doctorjs', {
        #"\ 'build' : {
          #"\ 'cygwin' : 'git submodule update --init; make -f Makefile install',
          #"\ 'unix' : 'git submodule update --init; sudo make -f Makefile install',
          #"\ 'mac' : 'git submodule update --init; sudo make -f Makefile install',
          #"\ }
        #"\ }
    #else
      #if iCanHazNeobundle == 0
        #echo 'Cannot find nodejs. Not installing doctorjs/jsctags'
      #endif
    #endif



    #if executable('tmux')
      git clone --recursive git@github.com:benmills/vimux
      git clone --recursive git@github.com:edkolev/tmuxline.vim
    #else
      #if iCanHazNeobundle == 0
        #echo 'Cannot find tmux. Not installing vimux or tmuxline'
      #endif
    #endif
    #if executable('w3m')
      #git clone --recursive git@github.com:yuratomo/w3m.vim
      #if iCanHazNeobundle == 0
        #echo 'Cannot find W3m. Not installing w3m.vim'
      #endif
    #endif
