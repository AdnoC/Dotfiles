scriptencoding utf-8
" Above line must be first thing in vimrc. Sets encoding used in this file

" Vim preferneces file

if !empty($NO_VIM_PLUGINS)
  let $STANDALONE_VIM_PLUGINS=1
  let $SIMPLE_VIM_PLUGINS=1
endif


" Initial {
" Remap leader. Needs to be done before any mappings involving the leader.
let mapleader="\<Space>"


" Platform specific directories {
" Vim looks for plugins in vimfiles instead of .vim in Windows
if has('nvim')
  let g:vim_directory = stdpath('config')
  let g:data_directory = stdpath('data')
else
  if has('gui_win32')
    let g:vim_directory = expand("$HOME/vimfiles")
  else
    let g:vim_directory = expand("$HOME/.vim")
  endif
  let g:data_directory = g:vim_directory
endif
" }

let g:vimrc_directory = expand(expand("<sfile>:p:h") . "/")

" Ensure we are using system python instead of virtualenv python
" https://www.reddit.com/r/neovim/comments/s3i0ez/how_to_avoid_having_to_install_neovim_in_every/
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

" Check whether there is an executable with a given name
" If we are using standalone plugins we automatically return false
function! HasExec(prog_name) abort
  let use_execs = empty($STANDALONE_VIM_PLUGINS)
  if a:prog_name == 'git'
    let use_execs = 1
  endif

  return use_execs && executable(a:prog_name)
endfunction
let g:COMPLETEOPT_SET=0
let g:USE_PLUGINS=0
if empty($NO_VIM_PLUGINS) && filereadable(g:vimrc_directory . ".vimrc_plugin")
  exec "so " . g:vimrc_directory . ".vimrc_plugin"
endif
" }

" Filetypes Specific Preferences {

" Set filetype for extension {
" How to set filetypes: (an example of setting one as ruby)
" au BufRead,BufNewFile *.rpdf       set ft=ruby
augroup UserFileTypeDefs
  autocmd!

  autocmd BufRead,BufFilePre,BufNewFile *.sls set filetype=yaml
  autocmd BufRead,BufFilePre,BufNewFile *.inc set filetype=php
  autocmd BufRead,BufFilePre,BufNewFile *.module set filetype=php
augroup END
" }

" CSharp {
" URL encode a string. ie. Percent-encode characters as necessary.
function! UrlEncode(string)

    let result = ""

    let characters = split(a:string, '.\zs')
    for character in characters
        if character == " "
            let result = result . "+"
        elseif CharacterRequiresUrlEncoding(character)
            let i = 0
            while i < strlen(character)
                let byte = strpart(character, i, 1)
                let decimal = char2nr(byte)
                let result = result . "%" . printf("%02x", decimal)
                let i += 1
            endwhile
        else
            let result = result . character
        endif
    endfor

    return result

endfunction

" Returns 1 if the given character should be percent-encoded in a URL encoded
" string.
function! CharacterRequiresUrlEncoding(character)

    let ascii_code = char2nr(a:character)
    if ascii_code >= 48 && ascii_code <= 57
        return 0
    elseif ascii_code >= 65 && ascii_code <= 90
        return 0
    elseif ascii_code >= 97 && ascii_code <= 122
        return 0
    elseif a:character == "-" || a:character == "_" || a:character == "." || a:character == "~"
        return 0
    endif

    return 1

endfunction
augroup UnityStuff
  autocmd!
  let s:unity_search_url = 'https://docs.unity3d.com/ScriptReference/30_search.html?q='
  function! SearchUnity() abort
    let new_search_url = s:unity_search_url . UrlEncode(expand('<cword>'))
    exec '!start ' . new_search_url
  endfunction

  au FileType cs set noexpandtab
  au FileType cs set shiftwidth=4
  au FileType cs set tabstop=4
  autocmd FileType cs nnoremap <leader>k :call SearchUnity()<CR>
augroup END

" }

" TextMarkdown {
" Lightweight format for note taking
augroup TextMarkdown
  autocmd!
  au BufRead,BufFilePre,BufNewFile *.txtmd set filetype=txt
  au BufRead,BufFilePre,BufNewFile *.txtmd setlocal foldenable
  au BufRead,BufFilePre,BufNewFile *.txtmd setlocal foldmethod=marker
  au BufRead,BufFilePre,BufNewFile *.txtmd let @o=" {{{"
  au BufRead,BufFilePre,BufNewFile *.txtmd let @c="<!--- }}} --->" . expand("\n")
augroup END
" }

" Help (Vim) {
augroup HelpSettings
  autocmd!
  " Press Enter to follow a help tag
  autocmd FileType help nnoremap <buffer><CR> <c-]>
  " Press Backspace to go back to the location of the previous tag
  autocmd FileType help nnoremap <buffer><BS> <c-T>
  " Press q to exit the help
  autocmd FileType help nnoremap <buffer>q :q<CR>
  autocmd FileType help setlocal nonumber
augroup END
" }

" Fzf (nvim integration) {
if has('nvim')
  augroup FZFNvim
    autocmd!
    autocmd TermOpen */*fzf* tnoremap <buffer><c-k> <UP>
    autocmd TermOpen */*fzf* tnoremap <buffer><c-j> <DOWN>
  augroup END
endif
" }

" Latex {
let g:tex_flavor = "latex"
augroup LatexSettings
  autocmd!
  autocmd FileType tex  if ! isdirectory('.LatexOutput') |
        \ exec "!mkdir .LatexOutput" |
        \ endif

  autocmd FileType tex exec "setlocal makeprg=latexmk\\ -outdir=\\\"" .
        \ expand('%:p:h') . expand('/') . ".LatexOutput\\\"\\ -pdf\\ %"

  autocmd FileType tex set conceallevel=2
  autocmd FileType markdown set conceallevel=2
augroup END
" }

" Msc {

augroup MscFileTypeSettings
  autocmd!
  " Use the java docs for keyword help
  "nnoremap <Leader>ls :w <BAR> !lessc % > ../css/%:t:r.css<CR><space>
  autocmd FileType less setlocal makeprg=lessc\ %\ >\ ../css/%:t:r.css

  " When editing plain text I don't need to see the ends of lines.
  autocmd FileType txt setlocal wrap linebreak nolist textwidth=0 wrapmargin=0

  autocmd FileType gitcommit set spell

  autocmd BufEnter *.js setlocal foldmethod=indent
augroup END
" }
" }

" Meta {
" Escape Aliases {
inoremap kj <ESC>
vnoremap kj <Esc>
snoremap kj <Esc>
" }

noremap <leader>tn :tabnew<CR>
noremap <leader>tc :tabclose<CR>

" Toggle paste mode.
set pastetoggle=<F11>

" Change vim pwd to dir of file to easily open other files in dir
nnoremap <leader>cd :cd %:p:h<CR>

" Save swap file annd trigger CursorHold sooner than the default 4 seconds
set updatetime=100

" Wildmenu {
" Turn on wild menu (Allow tab use with the command line)
set wildmenu
" Settings for wildmenu (:h wildmenu)
set wildmode=list:longest,list:full
" Disable for VCS and output files
set wildignore+=*.o,*.out,*.class,.git,tags
" Disable for archives
set wildignore+=*.zip,*.tar.gz
" Disable for temp files
set wildignore+=*.swp,*~
" }

" Allow the use of `vim: settings` to set for individual files.
" For some reason defaults to `off` on standard vim
set modeline

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Set where new splits are put
set splitright
set splitbelow

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

function! OpenScratchBuffer() abort
  new
  setlocal buftype=nofile
  setlocal noswapfile
  exec "nnoremap <buffer>q :bd\<CR\>"
  exec "resize " . (winheight(0) * 2 * 1/6)
endfunction

" Resize the current buffer
nnoremap <leader>rs :exe "resize " . (winheight(0) * 2 * 5/6)<CR>
if &diff
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
  if argc() == 2
    " Obtain diff from other file
    nnoremap do :diffget<CR>
    " Put diff into other file
    nnoremap dp :diffput<CR>
  else
    " If there is more than 2 files on startup we are most likely
    " called with `git mergetool`.
    nnoremap do :diffget RE<CR>
    nnoremap dp :diffget LO<CR>
    nnoremap dr :diffget RE<CR>
    nnoremap dl :diffget LO<CR>
  endif
endif

"""" Meta files (backup, swap) {
" Create backup, swap, and undo  folders if they do not exist
" Centralize backups, swapfiles and undo history
let backup_dir = expand(g:data_directory . '/backups')
let undo_dir = expand(g:data_directory . '/undo')
let swap_dir = expand(g:data_directory . '/swaps')
if ! isdirectory(backup_dir)
  call mkdir(backup_dir)
endif
 if ! isdirectory(swap_dir)
  call mkdir(swap_dir)
endif
if has('persistent_undo')
  " Store undo data in a file for persistence between sessions
  if ! isdirectory(undo_dir)
    call mkdir(undo_dir)
  endif
  exec "set undodir=" . fnameescape(undo_dir)
  set undofile
endif
exec "set backupdir=" . fnameescape(backup_dir)
exec "set directory=\"" . fnameescape(swap_dir)
" }

" Use utf-8 encoding. Needs to be set before listchars on some systems.
set encoding=utf-8
" }

" Looks {

" Refresh busted syntax highlighting (this happens too often)
nnoremap <F12> :syntax sync fromstart<CR>

" Cursor {
if has('win32unix') || !empty($IN_WSL) " Cygwin only
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

if has('nvim')
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
endif
" }

" Colors {
if empty($NO_VIM_GUICOLORS) && has("termguicolors") && !has('win32')
  set termguicolors
endif

" Don't turn syntax or highlight searching on unless there are enough colors
" to make them look good
if (&t_Co > 2 || has("gui_running") || $TERM =~ '-256color') && has("syntax")
  if !empty($TMUX)
    set t_ut=
  endif
    " Use 256 colors
    set t_Co=256
    " Start vim with solarized theme of the correct flavor
    syntax enable
    if $TERM_COLOR == 'light'
      set background=light
    else
      set background=dark
    endif

    " If using vimdiff, use a colorscheme that is actually readable.
    if &diff
      try
        colorscheme PaperColor
      catch
        colorscheme industry
      endtry
    " Otherwise pick the best for the situation
    elseif !g:USE_PLUGINS
      silent! colorscheme desert
    elseif has('win32') && !has('gui_running')
      silent! colorscheme elflord
    elseif empty($NO_VIM_GUICOLORS) && has("termguicolors")
        silent! colorscheme solarized8
    else
      " Silent so that it doesn't throw an error if the colorscheme doesn't exist
      silent! colorscheme solarized
    endif

    " If we are using a gui set the font in the proper format for that gui
    " nvim-qt uses its own configuration file
    if has("gui_gtk2")
      set guifont= DejaVu\ Sans\ Mono\ for\ Powerline\ 12
    elseif has("gui_macvim")
      set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12
    elseif has("gui_win32")
      set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12:cANSI
    endif
endif
" }

" Always use absolute line numbers
set number
" Use relative line numbers if we can
if exists("&relativenumber")
"   " This can cause lag (like when there is no v-sync) when scrolling.
  set relativenumber
endif

" Status line area stuff {
" Always show the status line (I use airline, so I want to see it)
set laststatus=2

" Always show tabline
set showtabline=2
"
" Show the number of changes made when doing substitutions
set report=0
" Don't show "ins-completion-menu" messages (shown when auto-completing)
set shortmess+=c
" }

" Don't beep on errors (like entering `:set xyz<CR>`)
set visualbell

" highlight current line and column
" These can cause lag (like when there is no v-sync) when scrolling.
set cursorline
set cursorcolumn

" Show column at x chars so that there is no lines to long
if exists('+colorcolumn')
  set colorcolumn=80
endif

" Show matching brackets when text indicator is over them"
set showmatch

" Displaying Meta Things (line end, etc) {
" Show hidden chars
set list
" Set hidden chars to show (Show tabs and trailing spaces)
if &encoding == "utf-8"
  if empty($SIMPLE_VIM_PLUGINS)
    exe "set listchars=eol:\u00ac,nbsp:\u001f,conceal:\u2315,tab:\u2595\u2014,precedes:\u2026,extends:\u2026"
    " What to display when a line is wrapped
    exe "set showbreak=\u21b3"
  else
    exe "set listchars=eol:\u00ac"
    exe "set listchars+=nbsp:\u001f"
    set listchars+=trail:-,tab:>-,extends:>,precedes:<,conceal:+
  endif
else
  set listchars=eol:$,trail:-,tab:>-,extends:>,precedes:<,conceal:+
endif
" }

" We are using a fairly fast terminal connection most times
set ttyfast

" When switching buffers, preserve window view.(Vim tip 1375)
if v:version >= 700
  augroup PreserveWindowView
    autocmd!
    autocmd BufLeave * if !&diff |
               \ let b:winview = winsaveview() |
               \ endif
    autocmd BufEnter * if exists('b:winview') && !&diff |
               \ call winrestview(b:winview) |
               \ unlet! b:winview |
               \ endif
  augroup END
endif
" }

" Formatting {
" Strips excess whitespace from file
nnoremap <leader>w :%s/\s\+$//<CR>:let @/=''<CR>
" Indentation {
" Use smart indenting when starting a new line
set autoindent
" Number of spaces to use for auto-indent ('>>' or '<<)
set shiftwidth=2
" Number of spaces (chars, not <SPACE>) a tab in a file counts for
set softtabstop=2
" Use an appropriate number of spaces instead of tabs when typing <Tab>
set expandtab
" At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes indentation
set smarttab
" Align indentation in case block with the label istelf instead of after
" the label.
set cinoptions+=l1
" Align indentation of labels in switch blocks with the switch statement
set cinoptions+=:0
" Align indentation of jump labels in general blocks with the block
set cinoptions+=Ls
" Align new lines in open parenthesis with the first item in the parenthesis
set cinoptions+=(0
" Align parenthesis like brackets
set cinoptions+=m1
" }

" The maximum width of a line of text. Lines that go longer will be broken
" after a whitespace
set textwidth=100

" Sets how vim formats text (see :h fo-table)
set formatoptions=qrno
" Set line ending preferences (CR LR stuff)
set fileformats=unix,dos,mac

" Folding {
" For highly nested languages, consider setting `foldcolumn`
" Auto include folds based on indent. Syntax-based folds can slow down opening large files.
set foldmethod=indent
" Open files with all folds open by default
set foldlevel=99
" }

" Reselect visual block after indent/outdent
xnoremap < <gv
xnoremap > >gv
" Re-hardwrap paragraph
nnoremap <leader>q gqip
" }

" Searching {
" Clears  the search by pressing <leader> COMMA
nnoremap <silent><leader>, :noh<CR>

set ignorecase             " ignore case when searching
set smartcase
" Use sane regexes
set magic

set incsearch   " Search incrementally
set hlsearch    " Highlight search matches

" If we have 'live substitution', enable it
if exists('&inccommand')
  set inccommand=split
endif
" }

" Msc. {
" Make Y behave like other capitals
nnoremap Y y$

" Replace a word with yanked text
nnoremap <leader>rp viw"0p

" Look for tag files in paths relative to cwd, not the file being edited
set cpoptions+=d
" Allow backspacing over everything in insert mode (:h bs)
set backspace=indent,eol,start

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>^m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

augroup FileChangedAlert
  " Helps if you have to use another editor on the same file
  autocmd! FileChangedShell * echoerr "File has been changed outside of Vim."
augroup END

" Number of lines to use for the command line
set cmdheight=2
" Completion Options {
" Be smart about case when using autocomplete
set infercase
" Specify how keyword completion works
set complete=.,t
if g:COMPLETEOPT_SET == 0
  set completeopt=longest,menu
endif

" }

" Functions {
" Displays a list of maps that include the leader
function! ListLeaders() abort
  silent! redir @b
  silent! nmap <LEADER>
  silent! redir END
  silent! new
  silent! set buftype=nofile
  silent! set bufhidden=delete
  silent! setlocal noswapfile
  silent! put! b
  silent! g/^s*$/d
  silent! %s/^.*,//
  silent! normal ggVg
  silent! sort
  silent! let lines = getline(1,"$")
  silent! normal <esc>
endfunction
command! ListLeaders :call ListLeaders()

" Saves the current file with a datestamp prepended to the name
" If given no args it saves using the current file name
" If given one arg it saves with the given arg as the file name
" If given two args it saves in the directory of the first arg with the second arg as the file name
" If doMove it moves the current file instead of saving a new file
function! DateSaveFunc(bang, doMove, ...) abort
  echo a:doMove
  if a:0 == 0
    let l:thisPath = expand('%:h')
    if l:thisPath == ''
      echoerr "Cannot add a date to an unnamed file"
      return 0
    else
      let l:newPath = a:bang . ' ' . fnameescape(l:thisPath . expand('/') . strftime('%Y%m%d') . '_' . expand('%:t'))
    endif
  elseif a:0 == 1
    let l:newPath =  a:bang . ' ' . fnameescape(expand('%:h') . expand('/') . strftime('%Y%m%d') . '_' . a:1)
  elseif a:0 == 2
    let l:thisPath = expand(a:1)
    let l:strLen = strchars(l:thisPath) - 1
    let l:lastChar = strpart(l:thisPath, l:strLen)
    if l:lastChar != '' && expand(l:lastChar) == expand('/')
      let l:thisPath = strpart(l:thisPath, 0, l:strLen)
    endif
    let l:newPath =  a:bang . ' ' . fnameescape(l:thisPath . expand('/') . strftime('%Y%m%d') . '_' . a:2)
  endif
  if a:doMove == 1
    exec 'Move' . l:newPath
  else
    exec 'keepalt saveas' . l:newPath
  endif
endfunction
command! -nargs=* -bang -complete=file DateSave :call DateSaveFunc(<q-bang>, 0, <f-args>)
command! -nargs=* -bang -complete=file DateMove :call DateSaveFunc(<q-bang>, 1, <f-args>)

function! ViewTexCharList() abort
  vnew
  edit $VIMRUNTIME/syntax/tex.vim
  silent! vertical resize 40

  silent! set bufhidden=delete
  silent! setlocal noswapfile
  nnoremap <buffer>q :q<CR>
  " Go to the first line of the file
  0
  " Search for (and therefore go to) the variable in which the list is stored
  /texMathList
  nohl
  " Make sure the list takes up most of the window
  silent! normal! zt
endfunction
command! -nargs=0 -buffer ViewTexCharList call ViewTexCharList()
" }
" }

" Movement {
" Check out http://stackoverflow.com/questions/16082991/vim-switching-between-files-rapidly-using-vanilla-vim-no-plugins
" Allows one to switch buffers without having to save or undo changes first.
set hidden
" The minimum number of line to keep above and below the cursor.
set scrolloff=10

" Paired Movements {
" Make buffer tab navigation quicker
" nnoremap ]b :bnext<CR>
" nnoremap [b :bprev<CR>
nnoremap ]t :tabnext<CR>
nnoremap [t :tabprev<CR>
" switch to last used buffer
nnoremap tt :b#<CR>

" Go to next spot in location list
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>

" Go to next spot in quickfix
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>
" }

" Mouse {
" Use a mouse mode that by default uses less mouse stuff
set mouse=nicr
" Turn off clicking so that we can use the mouse to scroll and nothing else
map <LeftMouse> <NOP>
map <2-LeftMouse> <NOP>
map <3-LeftMouse> <NOP>
map <4-LeftMouse> <NOP>
map <RightMouse> <NOP>
map <2-RightMouse> <NOP>
map <3-RightMouse> <NOP>
map <4-RightMouse> <NOP>
imap <LeftMouse> <NOP>
imap <2-LeftMouse> <NOP>
imap <3-LeftMouse> <NOP>
imap <4-LeftMouse> <NOP>
imap <RightMouse> <NOP>
imap <2-RightMouse> <NOP>
imap <3-RightMouse> <NOP>
imap <4-RightMouse> <NOP>
" }

" Move to the beginning and end of lines easier
"nnoremap H ^
"nnoremap L $

" Use sane movement along wrapped lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Make single quote jump to the character where the mark was placed at instead
" of just the line
nnoremap ' `
nnoremap ` '

" C-o, C-i for current buffer {
" https://stackoverflow.com/questions/7066456/vim-how-to-prevent-jumps-out-of-current-buffer
" Only jumps around the current buffer.
function! JumpInFile(back, forw) abort
  let [n, i] = [bufnr('%'), 1]
  let p = [n] + getpos('.')[1:]
  sil! exe 'norm!1' . a:forw
  while 1
    let p1 = [bufnr('%')] + getpos('.')[1:]
    if n == p1[0] | break | endif
    if p == p1
      sil! exe 'norm!' . (i-1) . a:back
      break
    endif
    let [p, i] = [p1, i+1]
    sil! exe 'norm!1' . a:forw
  endwhile
endfunction
nnoremap <silent><leader><C-o> :call JumpInFile("\<C-i>", "\<C-o>")<CR>
nnoremap <silent><leader><C-i> :call JumpInFile("\<C-o>", "\<C-i>")<CR>
" }

" Binds numpad home/end to move 1/2 page up/down.
" When I sit back to think I like moving around the page with only one hand,
" usually the right one. This lets me do that. Would use PgUp/PgDown, but Mintty
" or tmux captures those with my settings.
nnoremap <kEnd> <C-d>
nnoremap <kHome> <C-u>


" Hard Mode {
" Turn off arrow keys, and give some friendly advice
inoremap <Up> <C-o>:echom "Use k"<CR>
inoremap <Down> <C-o>:echom "Use j"<CR>
inoremap <Left> <C-o>:echom "Use h"<CR>
inoremap <Right> <C-o>:echom "Use l"<CR>
map <Up> <Esc>:echom "Use k"<CR>
map <Down> <Esc>:echom "Use j"<CR>
map <Left> <Esc>:echom "Use h"<CR>
map <Right> <Esc>:echom "Use l"<CR>
" }

" make window navigation easier.
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Basic jump-to-buffer for when we don't have Fzf
nnoremap <F5> :ls<CR>:buffer<SPACE>
if !empty($STANDALONE_VIM_PLUGINS)
  nnoremap <leader>b :ls<CR>:buffer<SPACE>
endif


" Terminal mappings {
if has('nvim')
  if empty($TMUX)
    tnoremap <C-s> <C-\><C-n>
  endif

  tnoremap <A-k><A-j> <C-\><C-n>
  tnoremap <C-q> <C-\><C-n>
  tnoremap <ESC> <C-\><C-n>

  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  if has('win32')
    augroup WinFzfFix
      autocmd!
      autocmd TermOpen *FZF tnoremap <buffer><C-k> <C-k>
      autocmd TermOpen *FZF tnoremap <buffer><C-j> <C-j>
    augroup END
  endif

  tnoremap [t <C-\><C-n>:tabprev<CR>
  tnoremap ]t <C-\><C-n>:tabnext<CR>
endif
" }
" }

" Load Local Prefs {
let $MYVIMRCLOCAL=expand(g:vim_directory . "/.vimrc.local")
"""" If there is a local vim configuration file, run it
if filereadable(g:vim_directory . "/.vimrc.local")
  exec "so " . g:vim_directory . "/.vimrc.local"
endif
" }

" Up For Removal {

" What was broken with the default?
" " Fix broken default mappings
" nmap dd d_

" Was already commented out
" " Use generic omnicompletion if something more specific isn't already set
" "if has("autocmd") && exists("+omnifunc")
"     "au Filetype *
"         "\ if &omnifunc == "" | setl omnifunc=syntaxcomplete#Complete | endif
" "endif

" }

" vim: foldmethod=marker foldmarker={,}
