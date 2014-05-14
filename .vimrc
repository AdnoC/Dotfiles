set nocompatible
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
	  syntax on
	  set hlsearch
endif

"Remap leader
let mapleader=","

set smartindent

" Use Control-a to move to normal mode
inoremap jj <Esc>

set nocompatible
set modelines=0

set shiftwidth=2

set relativenumber         " show how many lines away from current, for easier shortcut use.
set tabstop=2

" Slightly broken set cursorline
set ttyfast
set expandtab
set ruler                  " show the cursor position all the time
set noshowcmd              " don't display incomplete commands
set nolazyredraw           " turn off lazy redraw
"set number                 " line numbers
set wildmenu               " turn on wild menu
set wildmode=list:longest,full
set ch=2                   " command line height
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set visualbell             " shut the fuck up
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t
set whichwrap=b,s,h,l,<,>,[,]
" show current vim mode
set showmode
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set laststatus=2
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
" Line handling
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=100      " Show column at 80 chars so that there is no lines to long
                               
                            
"Searching
set ignorecase             " ignore case when searching
set smartcase
" Allows for better regex when searching
nnoremap ? /\v  
vnoremap ? /\v


set incsearch   " Shows matches
set showmatch
set hlsearch
" Clears  the search by pressing <leader> SPACE
nnoremap <leader><space> :noh<cr>      


" Show hidden chars
set list

" Allows one to switch buffers without having to save or undo changes first.
set hidden

nnoremap j gj
nnoremap k gk

" Remap ';' to ':' for easier commands
nnoremap ; :


" Get rid of the help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Turn off arrow keys in insert mode. Having them on can mess up typing once in a while.
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" Make window navigation easier.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Auto-save on focus loss
au FocusLost * :wa

nnoremap <leader>b :b!#<CR>
"Strips excess whitespace from file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>  
"Re-hardwrap paragraph
nnoremap <leader>q gqip     
"Open .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>      
"Select just-pasted text
nnoremap <leader>v V`] 
