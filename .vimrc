" Vim preferneces file
" Sections:
"   -> Plugins
"   -> Meta
"   -> Looks
"   -> Formatting
"   -> Searching
"   -> Msc
"   -> Movement
"
" Note: Mappings have a }{ symbol at the end of the line


""""""""""""""""""""""""""""""""""" Initial """""""""""""""""""""""""""""""""""
" This isn't Vi, it is Vi IMproved. So lets not cling to old Vi settings
set nocompatible
" Remap leader. Needs to be done before any mappings involving the leader.   }{
let mapleader=","

""""""""""""""""""""""""""""""""""" Plugins """""""""""""""""""""""""""""""""""
filetype off
execute pathogen#infect()
Helptags
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

"""" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"""" promptline
"let g:promptline_preset = {
"  \'a' : [ '\u', '\t' ],
"  \'b' : [ promptline#slices#host() ],
"  \'c' : [ promptline#slices#vcs_branch(),  promptline#slices#git_status() ],
"  \'z' : [ '\w' ],
"  \'warn' : [ promptline#slices#last_exit_code() ]}

""" lightline
"let g:lightline = {
"      \'colorscheme': 'darkblue',
"      \}

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
" Open the current directory in a new tab
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
" Store undo data in a file for persistence between sessions
set undofile
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

"""""""""""""""""""""""""""""""""""" Looks """"""""""""""""""""""""""""""""""""
"""" Color Schemes
set background=dark
"colorscheme slate
colorscheme darkblue

" Don't turn syntax or highlight searching on unless there are enough colors
" to make them look good
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    " Turn on syntax coloring
    syntax on                         "
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
set colorcolumn=100
" Show the number of changes made when doing substitutions
set report=0
" When closing a parenthesis or bracket (etc) briefly move cursor to its match
set showmatch
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

"""""""""""""""""""""""""""""""""" Movement """""""""""""""""""""""""""""""""""
" Number of lines to use for the command line
set cmdheight=2
" The minimum number of line to keep above and below the cursor.
set scrolloff=4
" Allow keys to move left or right to the prev/next line
set whichwrap=b,s,h,l,<,>,[,]

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
nnoremap <leader>b :b#<CR>
" make window navigation easier.                                             }{
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
