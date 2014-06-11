" Vim preferneces file
" Sections:
"   -> Initial
"   -> Plugins
"   -> File Types
"   -> Meta
"   -> Looks
"   -> Formatting
"   -> Searching
"   -> Msc
"   -> Movement
"   -> Key List and other things
"
" Note: Mappings have a }{ symbol at the end of the line
"


""""""""""""""""""""""""""""""""""" Initial """""""""""""""""""""""""""""""""""
" This isn't Vi, it is Vi IMproved. So lets not cling to old Vi settings
set nocompatible
" Remap leader. Needs to be done before any mappings involving the leader.   }{
let mapleader=","

""""""""""""""""""""""""""""""""""" Plugins """""""""""""""""""""""""""""""""""
filetype off
" Auto vundle install, taken from (before being slightly edited):
" http://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/Vundle.vim
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#rc()
    " Let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'
    "Add your bundles here
    Plugin 'kien/ctrlp.vim'
    Plugin 'edkolev/promptline.vim'
    Plugin 'scrooloose/syntastic'
    Plugin 'bling/vim-airline'
    "Plugin 'bling/vim-bufferline'
    Plugin 'mhinz/vim-signify'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'tpope/vim-surround'
    Plugin 'wikitopian/hardmode'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'scrooloose/nerdtree'
    Plugin 'kien/rainbow_parentheses.vim'
    " Ctags are a dependancy of tagbar
    if (executable('ctags'))
      Plugin 'majutsushi/tagbar'
    else
      echo "Could not find ctags. Not installing tagbar."
    endif
    Plugin 'sjl/gundo.vim'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'edsono/vim-matchit'
    Plugin 'tpope/vim-abolish'
    Plugin 'tpope/vim-repeat'
    Plugin 'StanAngeloff/php.vim'
        "...All your other bundles...
    if iCanHazVundle == 0
        echo "Installing Plugins, please ignore key map error messages"
        echo ""
        :PluginInstall
    endif
" Setting up Vundle - the vim plugin bundler end

" Brief help
" :PluginInstal
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins

filetype plugin indent on

"""" Syntastic
" Turn it on by default, so far no filetypes where it needs to be off.
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': [] }
" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
" Aggregate errors from multiple checkers
let g:syntastic_aggregate_errors = 1
" Automatically open location window if there are errors
let g:syntastic_auto_loc_list=1
" Show current error in command window
let g:syntastic_echo_current_error = 1
" Populate loclist with errors
let g:syntastic_always_populate_loc_list = 1
" Enable on open file
let g:syntastic_check_on_open = 1
" Set location list window height
let g:syntastic_loc_list_height = 5
" Shortcuts to prev/next errors                                              }{
nnoremap <leader>sn :lnext<CR>
nnoremap <leader>sp :lprevious<CR>

"""" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_theme')
  let g:airline_theme = 'solarized'
endif

"""" vim-gitgutter
" Tell gitgutter not to set any keybinds by itself. They will all be rebound.
let g:gitgutter_map_keys = 0
" Move from to the next/prev change                                          }{
nmap <leader>gj <Plug>GitGutterNextHunk
nmap <leader>gk <Plug>GitGutterPrevHunk
" Stage or revert the lines the cursor is on                                 }{
nmap <Leader>gs <Plug>GitGutterStageHunk
nmap <Leader>gr <Plug>GitGutterRevertHunk
" Preview the changes                                                        }{
nmap <Leader>gp <Plug>GitGutterPreviewHunk

let g:solarized_termcolors=256
let w:bg='dark'
call togglebg#map("<F5>")
function! ToggleBackground()
  if (w:bg=="light")
    set background=dark
    let w:bg='dark'
    colorscheme solarized
  else
    set background=light
    let w:bg='light'
    colorscheme solarized
endif
call LoadRainbow()
endfunction
map <F5> :call ToggleBackground()<CR>

"""" rainbow_parentheses
function! LoadRainbow()
  RainbowParenthesesActivate
  RainbowParenthesesLoadRound
  RainbowParenthesesLoadSquare
  RainbowParenthesesLoadBraces
  RainbowParenthesesLoadChevrons
endfunction
map <F6> :call LoadRainbow()<CR>

if (executable('ctags'))
  " Bind a button to open the tagbar                                         }{
  nnoremap <leader>tg :TagbarToggle<CR>
endif

" Bind a button to open NERD Tree                                            }{
nnoremap <leader>nt :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0
let NERDTreeShowHidden = 1

" Bind a button to open Gundo                                                }{
nnoremap <leader>gu :GundoToggle<CR>

" The default bind, just here so I remember
nnoremap <leader>ig :IndentGuidesToggle
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1


"nmap <leader> <Plug>(easymotion-prefix)

let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Make some easymotion binds
nmap <leader>l <Plug>(easymotion-lineforward)
nmap <leader>h <Plug>(easymotion-linebackward)
nmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)
nmap <leader>s <Plug>(easymotion-s2)
nmap <leader><ENTER> <Plug>(easymotion-sn)
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

let g:NERDCreateDefaultMappings=0
nmap <leader>cc <Plug>NERDCommenterComment
nmap <leader>cu <Plug>NERDCommenterUncomment

" Make rainbow parentheses an acual rainbow
let g:rbpt_colorpairs = [
  \ [ '13', '#6c71c4'],
  \ [ '5',  '#d33682'],
  \ [ '1',  '#dc322f'],
  \ [ '9',  '#cb4b16'],
  \ [ '3',  '#b58900'],
  \ [ '2',  '#859900'],
  \ [ '6',  '#2aa198'],
  \ [ '4',  '#268bd2'],
  \ ]

function! FixGUI()
  syntax enable
  set background=dark
  colorscheme solarized
  if &filetype!='php'
    call LoadRainbow()
  endif
endfunction
map <F9> :call FixGU I()<CR>
let a=((( ((( ((( (((5))) ))) ))) )))
"""""""""""""""""""""""""""""""""" File Types """""""""""""""""""""""""""""""""
" How to set filetypes: (an example of setting one as ruby)
" au BufRead,BufNewFile *.rpdf       set ft=ruby
autocmd BufRead,BufNewFile *.inc set filetype=php
autocmd BufRead,BufNewFile *.module set filetype=php

"""""""""""""""""""""""""""""""""""" Meta """""""""""""""""""""""""""""""""""""
" Remap ';' to ':' for easier commands                                       }{
nnoremap ; :
" Use Control-a to move to normal mode                                       }{
inoremap jj <Esc>
" Toggle paste mode.
set pastetoggle=<leader>p
" Makes the switch to paste mode immediately shown                           }{
map <leader>p :set invpaste paste?<CR>
" Change vim pwd to dir of file to easily open other files in dir            }{
nnoremap <leader>cd :cd %:p:h<CR>
" Open the current directory in a new tab                                    }{
nnoremap <leader>te :tabedit <c-r>=expand("%:p:h")<CR>/

" We aren't going to have any vim variables at the beginning or end of files
set modelines=0
" Turn on wild menu (Allow tab use with the command line)
set wildmenu
" Settings for wildmenu (:h wildmenu)
set wildmode=list:longest,list:full
" Get rid of the help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" auto-save on focus loss
au focuslost * :wa
" return to last edit position when opening files (you want this!)
autocmd bufreadpost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Open .vimrc                                                                }{
nnoremap <leader>ev <c-w><c-v><c-l>:e $MYVIMRC<CR>
"""" Meta files
" Create backup, swap, and undo  folders if they do not exist
" Centralize backups, swapfiles and undo history
 if ! isdirectory(expand('$HOME/.vim/backups'))
  call mkdir(expand('$HOME/.vim/backups'))
endif
 if ! isdirectory(expand('$HOME/.vim/swaps'))
  call mkdir(expand('$HOME/.vim/swaps'))
endif
 if has('persistent_undo')
  " Store undo data in a file for persistence between sessions
  set undofile
  if ! isdirectory(expand('$HOME/.vim/undo'))
    call mkdir(expand('$HOME/.vim/undo'))
  endif
  set undodir=~/.vim/undo
endif
set backupdir=~/.vim/backups
set directory=~/.vim/swaps

"""""""""""""""""""""""""""""""""""" Looks """"""""""""""""""""""""""""""""""""
"""" Color Scheme
" Start vim with dark solarized theme
au VimEnter * call FixGUI()
" If using vimdiff, use a colorscheme that is actually readable.
if &diff
  colorscheme blue
endif

" Don't turn syntax or highlight searching on unless there are enough colors
" to make them look good
if (&t_Co > 2 || has("gui_running")) && exists("syntax_on")
    " Turn on syntax coloring
    "syntax on
    " Highlight search matches
    set hlsearch
endif

" Use relative line numbers if we can
if exists("&relativenumber")
  set relativenumber
  au BufReadPost * set relativenumber
else
  " If there is no relative numbering on the system, use static numbers
  set number
endif

" Show on status bar line & column number, relative % in file
set ruler
" Don't display incomplete commands
set noshowcmd
" Shut the fuck up (Screen flashes instead of making a beep)
set visualbell
" Highlight current line (Horizontal underline)
set cursorline
" No need to show the mode, as airline will show it for us
set noshowmode
" Always show the status line (I use airline, so I want to see it)
set laststatus=2
" Wrap lines of text that are too long around to the next line
set wrap
" Show column at x chars so that there is no lines to long
set colorcolumn=80
" Show the number of changes made when doing substitutions
set report=0
" When closing a parenthesis or bracket (etc) briefly move cursor to its match
set showmatch
" How long in 1/10s of a second to show the match
set matchtime=5
" Use utf-8 encoding. Needs to be set before listchars on some systems.
set encoding=utf-8
" Show hidden chars
set list
" Set hidden chars to show (Show tabs and trailing spaces)
set listchars=tab:›\ ,trail:·,eol:¬,nbsp:_
" Turn off lazy redraw
set nolazyredraw
" We are using a fairly fast terminal connection most times
set ttyfast

""""""""""""""""""""""""""""""""" Formatting """"""""""""""""""""""""""""""""""
" Strips excess whitespace from file                                         }{
nnoremap <leader>w :%s/\s\+$//<CR>:let @/=''<CR>
" Converts existing tabs to spaces                                           }{
nnoremap <leader>t :retab<CR>
" Use smart indenting when starting a new line
set smartindent
" Number of spaces to use for auto-indent ('>>' or '<<)
set shiftwidth=2
" Number of spaces a tab in a file counts for
" shiftwidth spaces.
set tabstop=2
" Use an appropriate number of spaces instead of tabs when typing <Tab>
set expandtab
" At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes
set smarttab
" The maximum width of a line of text. Lines that go longer will be broken
" after a whitespace
set textwidth=100
" Sets how vim formats text (see :h fo-table)
set formatoptions=qrno
" Set line ending preferences (CR LR stuff)
set ffs=unix,dos,mac
" Re-hardwrap paragraph                                                      }{
nnoremap <leader>q gqip

"""""""""""""""""""""""""""""""""" Searching """"""""""""""""""""""""""""""""""
" Clears  the search by pressing <leader> SPACE                              }{
nnoremap <leader><space> :noh<CR>
set ignorecase             " ignore case when searching
set smartcase
" Allows for better regex when searching
nnoremap ? /\v
vnoremap ? /\v
set incsearch   " Search incrementally

"""""""""""""""""""""""""""""""""""" Msc. """""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up                  }{
noremap <Leader>m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm
" Allow backspacing over everything in insert mode (:h bs)
set backspace=indent,eol,start
" Specify how keyword completion works
set complete=.,t
set completeopt=longest,menu
" Open new split windows to right and bottom, which feels more natural
set splitbelow
set splitright
" Replace a word with yanked text                                            }{
nnoremap <leader>rp viw"0p

"""""""""""""""""""""""""""""""""" Movement """""""""""""""""""""""""""""""""""
" Number of lines to use for the command line
set cmdheight=2
" The minimum number of line to keep above and below the cursor.
set scrolloff=4
" Allow keys to move left or right to the prev/next line
set whichwrap=b,s,h,l,<,>,[,]

" Use sane movement along wrapped lines                                      }{
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Get off my lawn (Turn off arrow keys, and give some friendly advice)       }{
" Note: May wish to remove nmap for up/down because the commands slightly bleed
" over to insert mode for a time after the switch.
inoremap <Left> <C-o>:echom "Use h"<CR>
inoremap <Right> <C-o>:echom "Use l"<CR>
vnoremap <Left> <Esc>:echom "Use h"<CR>
vnoremap <Right> <Esc>:echom "Use l"<CR>
vnoremap <Up> <Esc>:echom "Use k"<CR>
vnoremap <Down> <Esc>:echom "Use j"<CR>
nnoremap <Left> :echom "Use h"<CR>
nnoremap <Right> :echom "Use l"<CR>
nnoremap <Up> :echom "Use k"<CR>
nnoremap <Down> :echom "Use j"<CR>

" Turn off up and down arrows completely in insert mode, as the mouse scroll
" is interpreted as scroll and gets past any other mapping and goes back to
" default behavior. Also preceding command with <Esc> isn't ideal.           }{
inoremap <Up> <nop>
inoremap <Down> <nop>

" Allows one to switch buffers without having to save or undo changes first.
set hidden

" Make tab navigation quicker                                                }{
nnoremap <Leader>] :bnext<CR>
nnoremap <leader>[ :bprev<CR>
" switch to last used tab                                                    }{
nnoremap tt :b#<CR>
" make window navigation easier.                                             }{
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

"""""""""""""""""""""""""""""""""" Key List """""""""""""""""""""""""""""""""""
" List of mapped keys:
" ,
" <leader>sn
" <leader>sp
" <leader>gk
" <leader>gj
" <leader>gs
" <leader>gr
" <leader>gp
" <leader>p
" jj
" <leader>cd
" <leader>te
" <leader>ev
" <leader>w
" <leader>t
" <leader>q
" <leader>m
" <leader><space>
" <leader>[
" <leader>]
" tt
" <c-h>
" <c-j>
" <c-k>
" <c-l>
" <leader>rp
" <leaer>gu
" <leader>tg
" <leader>nt
" <leader>l
" <leader>k
" <leader>j
" <leader>h
" <leader>s
" <leader><ENTER>


"""" If there is a local vim configuration file, run it
if filereadable(expand("~/.vimrc.local"))
  so ~/.vimrc.local
endif
