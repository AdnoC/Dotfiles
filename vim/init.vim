" TODO: Add settings for if the term is not utf-8
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
"   -> Other things
"
" Note: Mappings have a }{ symbol at the end of the line
"


""""""""""""""""""""""""""""""""""" Initial """""""""""""""""""""""""""""""""""
" This isn't Vi, it is Vi IMproved. So lets not cling to old Vi settings
if has('vim_starting')
  set nocompatible
endif
" Remap leader. Needs to be done before any mappings involving the leader.   }{
nnoremap <SPACE> <NOP>
onoremap <SPACE> <NOP>
let mapleader=" "

" Get SID prefix of vimrc (see :h <SID>)
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

" Vim looks for plugins in vimfiles instead of .vim in Windows
if has('gui_win32')
  let s:vimDirectory=expand("$HOME/vimfiles")
elseif has('nvim')
  let s:vimDirectory=expand("$HOME/.config/nvim")
else
  let s:vimDirectory=expand("$HOME/.vim")
endif
let s:vimDirectoryPart=expand(s:vimDirectory . "/")
let g:vimDirectory=s:vimDirectory


""""""""""""""""""""""""""""""""""" Plugins """""""""""""""""""""""""""""""""""
"""" Plugin Manager: (Vim-Plug)
let iCanHazVimPlug=1
" Download the manager if it isn't yet.
if empty(glob(expand(s:vimDirectory . '/autoload/plug.vim')))
  let iCanHazVimPlug=0
  " I know that all these could be replaced with just the git one. But I don't want to delete them
  if executable("curl")
    silent exec '!curl -fLo ' . shellescape(expand(s:vimDirectory."/autoload/plug.vim")) .
        \ ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  elseif executable("wget")
    " wget can't make folders on its own, so we need to make .vim/autoload for it
    if executable("mkdir")
      silent exec '!mkdir -p ' . shellescape(expand(s:vimDirectory."/autoload/"))
    endif
    silent exec '!wget -q -O ' . shellescape(expand(s:vimDirectory."/autoload/plug.vim")) .
        \ '  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  " If we are on Windows we can use Powershell to download it
  elseif executable("powershell")
    silent exec '!if not exist ' . shellescape(expand(s:vimDirectory."/autoload")) . ' mkdir ' .
      \ shellescape(expand(s:vimDirectory."/autoload/"))
    silent exec '!powershell "(new-object System.Net.WebClient).DownloadFile(''https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'',''' .
      \ shellescape(expand(s:vimDirectory."/autoload/plug.vim")) . ''')"'

  " If all else fails we can just use git.
  elseif executable("git")
    silent exec '!git clone -q --depth=1 git@github.com:junegunn/vim-plug.git ' . shellescape(expand(s:vimDirectory."/temp"))
    if has('gui_win32')
      let s:mv="move "
      let s:rm="del "
    else
      let s:mv="mv "
      let s:rm="rm -rf "
    endif
    silent exec '!' . s:mv . shellescape(expand(s:vimDirectory."/temp/plug.vim")) .
      \ ' ' . shellescape(expand(s:vimDirectory."/autoload/plug.vim"))
    silent exec '!' . s:rm . shellescape(expand(s:vimDirectory."/temp/"))
  else
    echo "Couldn't find a way to download Vim-Plug. Not sure how you were planning" .
      \ " installing plugins without Git."
  endif

  if has('nvim')
    " Install python client
    silent exec '!pip install neovim'
    if executable('pip3')
      silent exec '!pip3 install neovim'
    endif
  endif
  function! InstallMyPlugs()
    PlugInstall
    if has('nvim')
      UpdateRemotePlugins
    endif
  endfunction
  autocmd VimEnter * call InstallMyPlugs()
endif

" Required:
call plug#begin(s:vimDirectoryPart . 'bundle')
"Add your plugins here
" Does anything rely on vimproc?
"let vimproc_updcmd = has('win64') ?
  "\ 'tools\\update-dll-mingw 64' : 'tools\\update-dll-mingw 32'
"execute "NeoBundle 'Shougo/vimproc.vim'," . string({
  "\ 'build' : {
  "\     'windows' : vimproc_updcmd,
  "\     'cygwin' : 'make -f make_cygwin.mak',
  "\     'mac' : 'make -f make_mac.mak',
  "\     'unix' : 'make -f make_unix.mak',
  "\    },
  "\ })
"" Games:
Plug 'vim-scripts/TeTrIs.vim', { 'on': 'LoadTetris'}
function! LoadTetris()
endfunction
""" Git:
" NOTE: fugitive makes vim very laggy sometimes
" Commands for using git nicely in Vim
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
""" Auto Formatting:
Plug 'Raimondi/delimitMate'
""" Syntax:
Plug 'Konfekt/FastFold'
"NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box'
function! InstallGoBins(info)
  if a:info.status == 'installed'
    GoInstallBinaries
  elseif a:info.status == 'updated'
    GoUpdateBinaries
  endif
endfunction
Plug 'fatih/vim-go', { 'do': function('InstallGoBins')}
Plug 'vim-pandoc/vim-pandoc' | Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'
Plug 'jaxbot/semantic-highlight.vim', { 'for': 'javascript'}
if !&diff
  Plug 'scrooloose/syntastic'
endif
" Set indent options based on what is used in the file
" Plug 'tpope/vim-sleuth'
" General language pack
Plug 'sheerun/vim-polyglot'
" Adds syntax highlighting for some keywords in React. vim-polyglot already provides JSX syntax.
Plug 'othree/javascript-libraries-syntax.vim'
" Highlights matching HTML tags
" Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'php']}
" Auto-close HTML tags
" Plug 'vim-scripts/HTML-AutoCloseTag', { 'for': ['html', 'jsx']}
" Plug 'alvan/vim-closetag'
" Auto-close some structures (i.e. adds 'endfunction' after you type 'function!' in VimL)
Plug 'tpope/vim-endwise'
"NeoBundle 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesToggle'}
" YouCompleteMe only works on Linux/Mac and if vim is version > 7.3.584
" Use supertab if YCM won't work
if (has('lua') || has('nvim'))
  if has('nvim')
    let autocomplete_plugin="deoplete"
    Plug 'Shougo/deoplete.nvim'
  else
    let autocomplete_plugin="neocomplete"
    Plug 'Shougo/neocomplete.vim'
  endif
  " if executable('clang')
  "   Plug 'zchee/deoplete-clang'
  " elseif iCanHazVimPlug == 0
  "   echo 'Cannot find clang, not installing clang completion'
  " endif
  if executable('tern')
    Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript'}
  elseif iCanHazVimPlug == 0
    echo 'Cannot find tern, not installing javascript completion'
  endif
  if executable('gocode')
    Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go'}
  elseif iCanHazVimPlug == 0
    echo 'Cannot find gocode, not installing go completion'
  endif
  "
  if (! executable('jedi') && iCanHazVimPlug == 0)
    silent exec '!pip install jedi'
  endif
  Plug 'zchee/deoplete-jedi', { 'for': 'python'}
  " if executable('php')
  "   Plug 'm2mdas/phpcomplete-extended', { 'for': 'php'}
  " endif
else
  if 1 == 1
    let autocomplete_plugin="supertab"
    Plug 'ervandew/supertab'
  else
    let autocomplete_plugin="ycm"
    " If we have a new enough version of cmake, use upsteam
    let g:ycmInstallCommand = "/install.py --clang-completer --tern-completer --go-completer"
    Plug 'Valloric/YouCompleteMe', { 'do': g:ycmInstallCommand}
          \ | Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
  endif
endif
Plug 'Shougo/neosnippet.vim'| Plug 'Shougo/neosnippet-snippets'
Plug 'AdnoC/jcommenter.vim', { 'for': 'java'}
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript'}
" Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript'}
"autocmd FileType java NeoBundleSource jcommenter.vim
"NeoBundleLazy 'vim-scripts/Vim-JDE'
"autocmd FileType java NeoBundleSource Vim-JDE
Plug 'davetron5000/javax-xml-javadoc-vim', { 'for': 'java'}
Plug 'davetron5000/javax-javadoc-vim', { 'for': 'java'}
Plug 'davetron5000/java-javadoc-vim', { 'for': 'java'}
Plug 'vim-scripts/csv.vim', {'for': 'csv'}
" Python autocomplete
"NeoBundle 'davidhalter/jedi-vim'
""" Tools:
" Shows all 256 x-term colors in a nice table
Plug 'guns/xterm-color-table.vim'
" Fixes <C-A> and <C-X> to correctly increment/decrement dates
Plug 'tpope/vim-speeddating'
" Makes ga show additional info about a character
Plug 'tpope/vim-characterize'
" Shows (vim) syntax info as well as color of stuff.
Plug 'vim-scripts/SyntaxAttr.vim'
" Commands for using unix commands nicely in Vim
Plug 'tpope/vim-eunuch'
" Close buffers without closing windows
Plug 'qpkorr/vim-bufkill'
Plug 'tomtom/tcomment_vim'
" File Explorer Plugin
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'mbbill/undotree'
" Fuzzy search for files, buffers, and recent files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-user'
" Text Objects:
" Allows for things like 'cs2a([' to change ((*)) to [(*)]
Plug 'osyo-manga/vim-textobj-multiblock'
" Allows for text objects to be between any specified char
Plug 'thinca/vim-textobj-between'
" Allows for the use of 'b' as a text objext of any [('"<
Plug 'rhysd/vim-textobj-anyblock'
" Allows text objects to only exist on one side of the carot
Plug 'tommcdo/vim-ninja-feet'
Plug 'coderifous/textobj-word-column.vim'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-fold'
Plug 'glts/vim-textobj-comment'
""" Looks:
" Colorschemes
" A good solarized replacement. Has a grey background unless bash colors are overritten.
Plug 'romainl/flattened'
" A light colorscheme. Not sure about it.
Plug 'NLKNguyen/papercolor-theme'
Plug 'altercation/vim-colors-solarized'
" Makes the status bar & buffer bar look nice and display useful info
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Dims paragraphs besides the one you are working on
Plug 'junegunn/limelight.vim', { 'on': 'Limelight'}
" Removes distractions
Plug 'junegunn/goyo.vim', { 'on': ['GoyoEnter', 'Limelight']}
" Plug 'luochen1990/rainbow'
""" Movement:
Plug 'Lokaltog/vim-easymotion'
Plug 'wikitopian/hardmode', { 'on': ['ToggleHardMode', 'HardMode']}
" Lets you press 'f'/'F' for repeated movements
"NeoBundle 'rhysd/clever-f.vim'
Plug 'othree/html5.vim', { 'for': 'html'}
"NeoBundle 'tpope/vim-surround'
Plug 'rhysd/vim-operator-surround'
" Lets you replace text with something from a register (like pasting from register)
Plug 'kana/vim-operator-replace'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
" matchit breaks [] jumping. Only use it when 100% useful
Plug 'edsono/vim-matchit', { 'for': 'html'}


""" Tagbar:
" Ctags are a dependancy of tagbar
if executable('ctags')
  Plug 'majutsushi/tagbar'
  if executable('php') && !has('win32') "&& !has('win32unix')
    " Plug 'vim-php/phpctags'
    Plug 'vim-php/tagbar-phpctags.vim', { 'do': 'make'}
  endif
else
  if iCanHazVimPlug == 0
    echo 'Cannot find ctags. Not installing tagbar.'
  endif
endif

if executable('node') || executable('nodejs')
  if $UPSTREAM_YCM == 0
    Plug 'marijnh/tern_for_vim', { 'for': 'javascript'}
  endif
else
  if iCanHazVimPlug == 0
    echo 'Cannot find nodejs. Not installing doctorjs/jsctags'
  endif
endif
""" Tmux:
if executable('tmux')
  " Lets you use <C-hjkl> to move between both tmux and vim panes.
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'benmills/vimux'
  Plug 'edkolev/tmuxline.vim', { 'on': ['Tmuxline', 'TmuxlineSnapshot'] }
else
  if iCanHazVimPlug == 0
    echo 'Cannot find tmux. Not installing vimux or tmuxline'
  endif
endif
""" W3M:
if executable('w3m')
  Plug 'yuratomo/w3m.vim'
elseif iCanHazVimPlug == 0
  echo 'Cannot find W3m. Not installing w3m.vim'
endif

call plug#end()
    "...All your other bundles...
"if iCanHazVimPlug == 0
  "echo "Installing Plugins, please ignore key map error messages"
  "echo ""
  "NeoBundleCheck
"endif

"""" Vimballs:
" Installs all vimballs in the vimball directory
function! InstallVimballs()
  " For each file in the vimball diretcory...
  for f in split(glob(expand(s:vimDirectory . '/vimball/') . "*"))
    " Open the file in a new buffer
    exec 'new' f
    " Source the buffer
    source %
    " Then close the buffer
    bd
  endfor
endfunction

" If we are in a new installation and therefore are installing plugins...
if iCanHazVimPlug == 0
  echo "Intalling Vimballs"
  " Intall vimballs (UseVimball needs to be called after startup, therefore au)
  autocmd VimEnter * call InstallVimballs()
endif


"""" Syntastic:
" Turn it on by default, so far no filetypes where it needs to be off.
" let g:syntastic_mode_map = { 'mode': 'active',
"   \ 'active_filetypes': [],
"   \ 'passive_filetypes': ['java'] }
" Bind a button to check syntax when in passive mode                         }{
autocmd FileType java nnoremap <leader>cc :SyntasticCheck<CR>
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
" Check header files
let g:syntastic_cpp_check_header = 1
" Tell syntastic where SDL is located so it stops complaining
let g:syntastic_cpp_include_dirs = ['/usr/local/include/SDL2']
" Use modern C++ compile options
let g:syntastic_cpp_compiler_options = ' -std=c++11'
" Shortcuts to prev/next errors                                              }{
let g:syntastic_java_javac_config_file_enabled = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'
nnoremap <leader>s] :lnext<CR>
nnoremap <leader>s[ :lprevious<CR>

"""" NeoSnippet:
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)

"""" Deoplete:
"" Run deoplete.nvim automatically
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length=1
"
"""" Neocomplete:
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#auto_complete_start_length=1
let g:neocomplete#enable_smart_case = 1

" imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

"""" DeopleteGo:
let g:deoplete#sources#go#align_class = 1

"""" VimCloseTag:
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx"

"""" DelimitMate:
let g:delimitMate_expand_cr=1

"""" BufKill:
let g:BufKillCreateMappings=0

"""" Goyo:
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!

"""" Limelight:
let g:limelight_conceal_ctermfg = 'DarkGray'

"""" Vim Airline:
let g:airline#extensions#syntastic#enabled = 1
" Show a list of files on the top of the screen
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
let s:tablineBuffWidth = winwidth(0) / 5
if s:tablineBuffWidth < 20
  let s:tablineBuffWidth = 20
endif
let g:airline#extensions#tabline#fnametruncate = s:tablineBuffWidth
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#tab_min_count = 3

" Set the theme to solarized
if !exists('g:airline_theme')
  let g:airline_theme = 'solarized'
endif
" Use fancy fonts
if autocomplete_plugin == "ycm" && $UPSTREAM_YCM == 0
  let g:airline_powerline_fonts = 0
else
  let g:airline_powerline_fonts = 1
endif

" Only show git stats that are non-zero
let g:airline#extensions#hunks#non_zero_only=1
if executable('tmux')
  " Don't load tmuxline unless I decide to. It adds 1000ms to startuptime
  let g:airline#extensions#tmuxline#enabled=0
endif
" Clean up the status bar:
" Just show the list of files/buffers in section c
let g:airline_section_c = "%f%m %<%{bufname('#') != bufname('%') ? '('. bufname('#') .')' : ''}"
" No need for tagbar if we don't have ctags. Also don't call functions if the plugin isn't " installed.
if executable('ctags') && iCanHazVimPlug == 1
  " No need to show filetype in the status bar, the ctags section is enough
  " autocmd User AirlineAfterInit let g:airline_section_y = airline#section#create(['tagbar'])
  let g:airline_section_y = airline#section#create(['tagbar'])
endif
" Also don't need to know the formatting. Just leave it empty
let g:airline_section_x=''
" Automatically refresh airline when changing colorschemes. This fixes the arrows.
autocmd VimEnter * autocmd ColorScheme * AirlineRefresh

"""" Vim Gitgutter:
" Tell gitgutter not to set any keybinds by itself. They will all be rebound.
let g:gitgutter_map_keys = 0
" Move from to the next/prev change                                          }{
nmap ]g <Plug>GitGutterNextHunk
nmap [g <Plug>GitGutterPrevHunk
" Stage or revert the lines the cursor is on                                 }{
nmap <Leader>gs <Plug>GitGutterStageHunk
nmap <Leader>gr <Plug>GitGutterRevertHunk
" Preview the changes                                                        }{
nmap <Leader>gp <Plug>GitGutterPreviewHunk
let g:gitgutter_eager = 0


"""" Solarized:
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_visibility='high'

"""" Rainbow:
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['#6c71c4', '#d33682', '#dc322f', '#cb4b16', '#b58900', '#859900', '#2aa198', '#268bd2'],
\   'ctermfgs': ['13', '5', '1', '9', '3', '2', '6', '4'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\   }
\}
"
" Fixes most gui problems (broken syntax coloring, status bar no color)      }{
function! FixGUI()
  syntax enable
  if expand("$TERM_COLOR") == 'light'
    set background="light"
  else
    set background="dark"
  endif
  colorscheme solarized
endfunction
map <F9> :call FixGUI()<CR>

"""" Tagbar:
" Bind a button to open the tagbar                                         }{
nnoremap <leader>tg :TagbarToggle<CR>
let g:tagbar_autoclose=1
let g:tagbar_autofocus=1

"""" UndoTree:
" Bind a button to open UntoDree                                             }{
nnoremap <leader>gu :UndotreeToggle<CR>

"""" Indent Lines:
let g:indentLine_enabled=0
" The default bind, just here so I remember
nnoremap <leader>ig :IndentLinesToggle<CR>


"""" Easy Motion:
" NOTE: omaps are used when using 'c' and 'd' operators
"nmap <leader> <Plug>(easymotion-prefix)
omap <leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Make some easymotion binds                                                 }{
nmap <leader>l <Plug>(easymotion-lineforward)
omap <leader>l <Plug>(easymotion-lineforward)
nmap <leader>h <Plug>(easymotion-linebackward)
omap <leader>h <Plug>(easymotion-linebackward)
nmap <leader>j <Plug>(easymotion-j)
omap <leader>j <Plug>(easymotion-j)
vmap <leader>j <Plug>(easymotion-j)
omap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)
omap <leader>k <Plug>(easymotion-k)
vmap <leader>k <Plug>(easymotion-k)
omap <leader>k <Plug>(easymotion-k)
nmap <leader>s <Plug>(easymotion-s2)
omap <leader>s <Plug>(easymotion-s2)
vmap <leader>s <Plug>(easymotion-s2)
omap <leader>s <Plug>(easymotion-s2)
nmap <leader><ENTER> <Plug>(easymotion-sn)
omap <leader><ENTER> <Plug>(easymotion-sn)
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

"""" W3m:
" Bind w3m to an easy key and add http so it doesn't search.                 }{
nnoremap <leader>w3 :W3m http://
autocmd FileType w3m nnoremap <buffer>q :W3mClose<CR>
autocmd FileType w3m nnoremap <buffer>o :W3mAddressBar<CR>

"""" FZF:
let g:fzf_command_prefix="Fzf"
nmap <leader>p :FZF<CR>
nmap <leader>b :FzfBuffers<CR>
nmap <leader>t :FzfBTags<CR>
autocmd FileType javascript command! -buffer -bang -nargs=* FzfBTags
  \ call fzf#vim#buffer_tags(<q-args>,
  \ [printf('jsctags %s -f', expand('%:S'))],
  \ <bang>0 ? {} : copy(get(g:, 'fzf_layout', g:fzf#vim#default_layout)))
    " \ printf('ctags -f - --sort=no --excmd=number --language-force=%s %s', &filetype, expand('%:S')),
    " \ printf('ctags -f - --sort=no --excmd=number %s', expand('%:S'))], {})

"""" Vimux:                                                                  }{
map <leader>vp :VimuxPromptCommand<CR>
map <leader>vr :VimuxRunLastCommand<CR>
map <leader>vo :VimuxInspectRunner<CR>
map <leader>vc :VimuxCloseRunner<CR>

"""" Gitv:
" Be Smart About Whether To Open The Browser In A Horizontal Or Vertical Tab
let g:Gitv_OpenHorizontal='auto'
" Mercilessly Purge All Fugitive Buffers In The Browser Tab
let g:Gitv_WipeAllOnClose=1
" Don't map the ctrl key. otherwise I'd constantly open new windows
let g:Gitv_DoNotMapCtrlKey = 1

"""" PreserveNoEOL:
let g:PreserveNoEOL=1

"""" PIV
" Don't let it map, because it causes ',' to hava a delay
let g:PIVCreateDefaultMappings = 0
" AutoPHPFolding really hits performance, making cursor movement and switching bufers laggy
let g:DisableAutoPHPFolding = 1

"""" TComment:
let g:tcommentGuessFileType_php = "php"

"""" JCommenter:
" Set author config
augroup JCommenterSettings
  autocmd!
  autocmd FileType java let g:jcommenter_class_author='Adam Cutler'
  autocmd FileType java let g:jcommenter_file_author='Adam Cutler'
  autocmd FileType java let g:jcommenter_method_description_space = 1
  " Create a bind to generate comments                                         }{
  autocmd FileType java nmap <leader>cj :call JCommentWriter()<CR>
  autocmd FileType java nmap <leader>c] :call SearchInvalidComment(0)<cr>
  autocmd FileType java nmap <leader>c[ :call SearchInvalidComment(1)<cr>
augroup END

"""" VimJSDoc:
let g:jsdoc_allow_input_prompt=1
let g:jsdoc_additional_descriptions=1
let g:jsdoc_default_mapping=0
"                                                                            }{
augroup VIMJSDOC
  autocmd!
  autocmd FileType javascript nmap <leader>cj :JsDoc<CR>
augroup END

"""" VimJDE:
if executable('ant')
  function! s:Set_VJDE_Lib_Path()
    if !exists("g:vjde_lib_path")
      let g:vjde_lib_path=system("ant -q cp | grep echo | cut -f2- -d] | tr -d ' ' | tr ':' '\n'")
    endif
  endfunction
  " The system call takes a long time (700 ms), so don't do it unless we are editing a java file
  autocmd FileType java call s:Set_VJDE_Lib_Path()
endif

"""" SyntaxAttr:
nmap <leader>a :call SyntaxAttr()<CR>

"""" SemanticHighlight:
let s:semanticTermColorsDark = [28,1,2,3,4,5,6,7,25,9,10,34,12,13,14,15,16,125,124,19]
let s:semanticTermColorsLight = [28,1,2,3,4,5,6,8,25,9,10,34,12,13,14,17,16,125,124,19]

"""" VimPandoc:
let g:pandoc#keyboard#use_default_mappings = 0
augroup PandocBinds
  autocmd FileType pandoc nmap <buffer>go <Plug>(pandoc-keyboard-links-open)
  autocmd FileType pandoc nmap <buffer>gb <Plug>(pandoc-keyboard-links-back)
augroup END



"""" VimOperatorSurround:
" operator mappings                                                         }{
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sc <Plug>(operator-surround-replace)

"""" VimOperatorReplace:
map <silent><leader>re <Plug>(operator-replace)

"""" TextobjComment:
let g:textobj_comment_no_default_key_mappings = 1
xmap ax <Plug>(textobj-comment-a)
omap ax <Plug>(textobj-comment-a)
xmap ix <Plug>(textobj-comment-i)
omap ix <Plug>(textobj-comment-i)
xmap aX <Plug>(textobj-comment-big-a)
omap aX <Plug>(textobj-comment-big-a)
xmap iX <Plug>(textobj-comment-big-i)
omap iX <Plug>(textobj-comment-big-i)

" Using vim-operator-user (With NERDCommenter)
" http://relaxedcolumn.blog8.fc2.com/blog-entry-154.html
"function! s:setCommentOperator(key, name)
    "call operator#user#define(
    "\   'comment-' . a:name,
    "\   s:SID_PREFIX() . 'doCommentCommand',
    "\   'call ' . s:SID_PREFIX() . 'setCommentCommand("' . a:name . '")')
    "execute 'map' a:key '<Plug>(operator-comment-' . a:name . ')'
"endfunction

"function! s:setCommentCommand(command)
    "let s:comment_command = a:command
"endfunction

"function! s:doCommentCommand(motion_wiseness)
    "let v = operator#user#visual_command_from_wise_name(a:motion_wiseness)
    "execute 'normal! `[' . v . "`]\<Esc>"
    "echo s:comment_command
    "call NERDComment('x', s:comment_command)
"endfunction

"call s:setCommentOperator('<leader>cv', 'comment')
"call s:setCommentOperator('<leader>cx', 'uncomment')


"""""""""""""""""""""""""""""""""" File Types """""""""""""""""""""""""""""""""
" How to set filetypes: (an example of setting one as ruby)
augroup UserFileTypeDefs
   autocmd!
" au BufRead,BufNewFile *.rpdf       set ft=ruby

  au BufRead,BufFilePre,BufNewFile *.sls set filetype=yaml
  au BufRead,BufFilePre,BufNewFile *.inc set filetype=php
  au BufRead,BufFilePre,BufNewFile *.module set filetype=php
augroup END

if executable('ant')
  augroup JavaMakeSettings
    autocmd!
    autocmd FileType java setlocal makeprg=ant\ -find\ 'build.xml'
    autocmd FileType java compiler ant
    autocmd FileType java setlocal shellpipe=2>&1\ \|\ tee
  augroup END
endif
let java_highlight_all=1

augroup FileTypeSpecificCmds
  autocmd!
  " Use the java docs for keyword help
  autocmd FileType java setlocal keywordprg=
  "nnoremap <Leader>ls :w <BAR> !lessc % > ../css/%:t:r.css<CR><space>
  autocmd FileType less setlocal makeprg=lessc\ %\ >\ ../css/%:t:r.css
  autocmd FileType plaintex set ft=tex

  autocmd FileType tex  if ! isdirectory('LatexOutput') |  exec "!mkdir LatexOutput" |  endif

  autocmd FileType tex exec "setlocal makeprg=latexmk\\ -outdir=\\\"" . expand('%:p:h') . expand('/') . "LatexOutput\\\"\\ -pdf\\ %"

  " autocmd FileType tex set conceallevel=0

  autocmd FileType pandoc  if ! isdirectory('PandocOutput') |  exec "!mkdir PandocOutput" |  endif
  " autocmd FileType markdown exec "setlocal makeprg=pandoc\\ -s\\ --to=html\\ --output=\\\"" . expand('%:h') . expand('/') . "PandocOutput" . expand('/') . expand('%:r') . ".html\\\"\\ %"
  " autocmd FileType pandoc exec "setlocal makeprg=pandoc\\ -s\\ --output=\\\"" . expand('%:h') . expand('/') . "PandocOutput" . expand('/') . expand('%:r') . ".pdf\\\"\\ %"
  autocmd FileType pandoc exec "setlocal makeprg=pandoc\\ -s\\ --output=\\\"" . expand('%:h') . expand('/') . "PandocOutput" . expand('/') . expand('%:r') . ".html\\\"\\ %"
  function! ViewPandoc()
    exec "!cat " . expand('%:h') . expand('/') . "PandocOutput" . expand('/') . expand('%:r') . ".html \| w3m -T text/html"
  endfunction
  autocmd FileType pandoc command! -nargs=0 -buffer ViewPandoc call ViewPandoc()
  " Turn spellcheck off because we are going to be using words that aren't in the dictionary
  autocmd FileType pandoc setlocal nospell
  " Use 4 spaces per tab since thats the magic number for pandoc
  autocmd FileType pandoc setlocal shiftwidth=4

  " When editing plain text I don't need to see the ends of lines.
  autocmd FileType txt setlocal wrap linebreak nolist textwidth=0 wrapmargin=0
augroup END
" let g:tex_conceal = ""

" Vim doesn't play nice with javascript's anonymous function use. This makes the code actually have
" colors.
augroup JavascriptPls
  autocmd!
  autocmd BufEnter *.js SemanticHighlight
  autocmd BufEnter *.js setlocal foldmethod=indent
augroup END

"""""""""""""""""""""""""""""""""""" Meta """""""""""""""""""""""""""""""""""""
" Use Control-a to move to normal mode                                       }{
inoremap jk <Esc>
" Allow the use of a familiar key combination to exit visual mode            }{
vnoremap jk <Esc>
" Toggle paste mode.
set pastetoggle=<F11>
" Makes the switch to paste mode immediately shown                           }{
map <F11> :set invpaste paste?<CR>
" Change vim pwd to dir of file to easily open other files in dir            }{
nnoremap <leader>cd :cd %:p:h<CR>
" Open the current directory in a new tab                                    }{
nnoremap <leader>tbe :tabedit <c-r>=expand("%:p:h")<CR>/
" Fix broken default mappings
nmap dd d_
" We aren't going to have any vim variables at the beginning or end of files
set modelines=1
set modeline
" Turn on wild menu (Allow tab use with the command line)
set wildmenu
" Settings for wildmenu (:h wildmenu)
set wildmode=list:longest,list:full
" Get rid of the help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Disable some things if the file is very large.
let g:LargeFile = 1024 * 1024 * 1
let b:gitGutEnAu = 0
function! LargeFileGitgutter()
  let f=expand("<afile>")
  if getfsize(f) > g:LargeFile
    let g:gitgutter_enabled = 0
    let g:gitgutter_realtime = 0
    if b:gitGutEnAu == 0
      autocmd BufWritePost <buffer> :GitGutterEnable
    endif
    let b:gitGutEnAu = 1
  endif
endfunction
augroup LargeFile
  autocmd!
  " Gitgutter slows vim to a halt if the file is to big, so turn it off in those cases.
  autocmd BufReadPre * call LargeFileGitgutter()
augroup END

" Use generic omnicompletion if something more specific isn't already set
"if has("autocmd") && exists("+omnifunc")
    "au Filetype *
        "\ if &omnifunc == "" | setl omnifunc=syntaxcomplete#Complete | endif
"endif

" auto-save on focus loss
au FocusLost * :wa
" return to last edit position when opening files (you want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Open .vimrc                                                                }{
nmap <leader>ev <c-w><c-s><c-l>:e $MYVIMRC<CR>|:exec "nnoremap <buffer>q :bd\<CR\>"<CR>
" Open a scratch buffer
nmap <leader>cs :new|:set buftype=nofile<CR>|:setlocal noswapfile<CR>|:exec "nnoremap <buffer>q :bd\<CR\>"<CR>|:exe "resize " . (winheight(0) * 2 * 1/6)<CR>
" Resize the current buffer                                                  }{
nnoremap <leader>rs :exe "resize " . (winheight(0) * 2 * 5/6)<CR>
  "silent! set buftype=nofile
  "silent! set bufhidden=hide
  "silent! setlocal noswapfile
"""" Meta files
" Create backup, swap, and undo  folders if they do not exist
" Centralize backups, swapfiles and undo history
 if ! isdirectory(s:vimDirectoryPart . 'backups')
  call mkdir(s:vimDirectoryPart . 'backups')
endif
 if ! isdirectory(s:vimDirectoryPart . 'swaps')
  call mkdir(s:vimDirectoryPart . 'swaps')
endif
 if has('persistent_undo')
  " Store undo data in a file for persistence between sessions
  if ! isdirectory(s:vimDirectoryPart . 'undo')
    call mkdir(s:vimDirectoryPart . 'undo')
  endif
  exec "set undodir=" . s:vimDirectoryPart . "undo"
  set undofile
endif
exec "set backupdir=" . s:vimDirectoryPart . "backups"
exec "set directory=" . s:vimDirectoryPart . "swaps"

"if has('gui_win32')
"  source $VIMRUNTIME/mswin.vim
"endif
"
" Was in default gVim vimrc
if has('gui') && has('vim_starting')
  set diffexpr=MyDiff()
  function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        let cmd = '""' . $VIMRUNTIME . '\diff"'
        let eq = '"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
  endfunction

" Get the args that Vim was opened with
  redir @a
  silent args
  redir END
  " If we are running the GUI and we didn't open a specific file, move to ~ so that
  " we aren't in the folder where Vim was installed to
  if has('gui') && @a == ''
    cd ~
  endif
endif

"""""""""""""""""""""""""""""""""""" Looks """"""""""""""""""""""""""""""""""""
"""" Color Scheme
" If using vimdiff, use a colorscheme that is actually readable.
if &diff
  colorscheme blue
  nmap <leader>. :diffget RE<CR>
  nmap <leader>m :diffget LO<CR>
endif

if has('win32unix')
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif
" Refresh busted syntax highlighting (this happens too often)                }{
map <F12> :syntax sync fromstart<cr>

" Don't turn syntax or highlight searching on unless there are enough colors
" to make them look good
if (&t_Co > 2 || has("gui_running") || $TERM =~ '-256color') && has("syntax")
  if !empty($TMUX)
    set t_ut=
    let g:asdf="YES"
  endif
    " Use 256 colors
    set t_Co=256
    " Start vim with solarized theme of the correct flavor
    syntax enable
    if expand("$TERM_COLOR") == 'light'
      set background="light"
      let g:semanticTermColors =s:semanticTermColorsLight
    else
      let g:semanticTermColors =s:semanticTermColorsDark
      set background="dark"
    endif
    " Silent so that it doesn't throw an error if the colorscheme doesn't exist
    silent! colorscheme solarized

    if has("gui_running")
      set guioptions-=T
    endif
    " If we are using a gui set the font in the proper format for that gui
    if has("gui_gtk2")
      set guifont= DejaVu\ Sans\ Mono\ for\ Powerline\ 12
    elseif has("gui_macvim")
      set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12
    elseif has("gui_win32")
      set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12:cANSI
    endif
    " Highlight search matches
    set hlsearch
endif

" Use relative line numbers if we can
" if exists("&relativenumber")
"   " This caused lag (like when there is no v-sync) when scrolling.
"   set relativenumber
"   "au BufReadPost * set relativenumber
" else
  " If there is no relative numbering on the system, use static numbers
set number
" endif

" Show on status bar line & column number, relative % in file
set ruler
" Don't display incomplete commands
set noshowcmd
" Shut the fuck up (Screen flashes instead of making a beep)
set visualbell
" Highlight current line (Horizontal underline)
" This caused lag (like when there is no v-sync) when scrolling.
" set cursorline
" No need to show the mode, as airline will show it for us
set noshowmode
" Always show the status line (I use airline, so I want to see it)
set laststatus=2
" Wrap lines of text that are too long around to the next line
set wrap
" Show column at x chars so that there is no lines to long
if exists('+colorcolumn')
  set colorcolumn=80
endif
" Show the number of changes made when doing substitutions
set report=0
" Show matching brackets when text indicator is over them"
set showmatch
" How long in 1/10s of a second to show the match
set matchtime=5
" Use utf-8 encoding. Needs to be set before listchars on some systems.
set encoding=utf-8
" Show hidden chars
set list
" Set hidden chars to show (Show tabs and trailing spaces)
if &encoding == "utf-8"
  exe "set listchars=eol:\u00ac,nbsp:\u001f,conceal:\u2315,tab:\u2595\u2014,precedes:\u2026,extends:\u2026"
  exe "set sbr=\u21b3"
else
  set listchars=eol:$,trail:-,tab:>-,extends:>,precedes:<,conceal:+
endif
" Turn off lazy redraw
set nolazyredraw
" We are using a fairly fast terminal connection most times
set ttyfast
" When switching buffers, preserve window view.(Vim tip 1375)
if v:version >= 700
  au BufLeave * if !&diff | let b:winview = winsaveview() | endif
  au BufEnter * if exists('b:winview') && !&diff | call winrestview(b:winview) | unlet! b:winview | endif
endif


""""""""""""""""""""""""""""""""" Formatting """"""""""""""""""""""""""""""""""
" Strips excess whitespace from file                                         }{
nnoremap <leader>w :%s/\s\+$//<CR>:let @/=''<CR>
" Converts existing tabs to spaces                                           }{
nnoremap <leader>rt :retab<CR>
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
set fileformats=unix,dos,mac
" Creates a gutter on the left side ofthe screen showing fold info
" By default do not show the gutter
autocmd FileType * set foldcolumn=0
" Show the gutter for only specified filetypes
autocmd FileType javascript setlocal foldcolumn=6
" Auto include folds based on indent. Syntax-based folds can slow down opening large files.
set foldmethod=indent
" Open files with all folds open by default
set foldlevel=99
" Reselect visual block after indent/outdent                                }{
vnoremap < <gv
vnoremap > >gv
" Re-hardwrap paragraph                                                      }{
nnoremap <leader>q gqip


"""""""""""""""""""""""""""""""""" Searching """"""""""""""""""""""""""""""""""
" Clears  the search by pressing <leader> COMMA                              }{
nnoremap <silent><leader>, :noh<CR>
set ignorecase             " ignore case when searching
set smartcase
" Use sane regexes                                                           }{
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
set incsearch   " Search incrementally


"""""""""""""""""""""""""""""""""""" Msc. """""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up                  }{
noremap <Leader>^m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm
" Allow backspacing over everything in insert mode (:h bs)
set backspace=indent,eol,start
" Be smart about case when using autocomplete
set infercase
" Helps if you have to use another editor on the same file
au FileChangedShell * echoerr "File has been changed outside of Vim."
" Specify how keyword completion works
set complete=.,t
set completeopt=longest,menu
" Open new split windows to right and bottom, which feels more natural
set splitbelow
set splitright
" Make Y behave like other capitals                                          }{
nnoremap Y y$
" Replace a word with yanked text                                            }{
nnoremap <leader>rp viw"0p
" Don't take too long if a mapping is an incomplete version of another
set timeoutlen=250
"""" Help
" Press Enter to follow a help tag
au filetype help nnoremap <buffer><CR> <c-]>
" Press Backspace to go back to the location of the previous tag
au filetype help nnoremap <buffer><BS> <c-T>
" Press q to exit the help
au filetype help nnoremap <buffer>q :q<CR>
au filetype help set nonumber
" Displays a list of maps that include the leader
function! ListLeaders()
  silent! redir @b
  silent! nmap <LEADER>
  silent! redir END
  silent! new
  silent! set buftype=nofile
  silent! set bufhidden=hide
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
function! DateSaveFunc(bang, doMove, ...)
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

"""""""""""""""""""""""""""""""""" Movement """""""""""""""""""""""""""""""""""
" Number of lines to use for the command line
set cmdheight=2
" The minimum number of line to keep above and below the cursor.
set scrolloff=10
" Allow keys to move left or right to the prev/next line
set whichwrap=b,s,h,l,<,>,[,]

" Use the mouse if we have a gui
if has('gui')
  set mouse=a
" If we are on command line, ignore the mouse
else
  set mouse=
endif

" Move to the beginning and end of lines easier                              }{
"nnoremap H ^
"nnoremap L $

" Use sane movement along wrapped lines                                      }{
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk


" Only jumps around the current buffer.                                      }{
function! JumpInFile(back, forw)
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

" Binds numpad home/end to move 1/2 page up/down.
" When I sit back to think I like moving around the page with only one hand,
" usually the right one. This lets me do that. Would use PgUp/PgDown, but Mintty
" or tmux captures those with my settings.                                   }{
nnoremap <kEnd> <C-d>
nnoremap <kHome> <C-u>


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
nnoremap <Up> <nop>
nnoremap <Down> <nop>

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


"""" Notes
":bro ol (AKA :browse oldfiles) lists previously opened files and allows you to open one
"<c-o> Returns you to locations before jumps. <c-i> (also tab) moves you forward

"""" If there is a local vim configuration file, run it
if filereadable(s:vimDirectoryPart . ".vimrc.local")
  exec "so " . s:vimDirectoryPart . ".vimrc.local"
endif
