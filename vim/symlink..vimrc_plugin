" Vim plugin configuration

" A simpler plugin setup is available for environments where some things are not
" available.
" It disables some plugins that have a usage cost.
" To enable it, set the environmental variable SIMPLE_VIM_PLUGINS.

" If you want to setup a plugin config for a minimal environment (such as a phone),
" set the environmental variable STANDALONE_VIM_PLUGINS.
" It will make sure that the only plugins enabled are those that depend wholly on
" vimL.

" Set that we decided to use plugins
let g:USE_PLUGINS=1
let $MYVIMRCPLUGIN=expand('<sfile>')

" Plugin Alternatives: {
" Used in checking which of several alternatives is used
let s:syntax_syntastic = 'syntastic'
let s:syntax_neomake = 'neomake'
let g:autocomplete_ycm = 'ycm'
let g:autocomplete_neocomplete = 'neocomplete'
let g:autocomplete_deoplete = 'deoplete'
let g:autocomplete_supertab = 'supertab'
let g:autocomplete_ncm = 'ncm'
" }

"""" Plugin Manager: (Vim-Plug)
let VimPlugInitialized=1
" Download plugin manager {
if empty(glob(expand(g:vimDirectory . '/autoload/plug.vim')))
  let VimPlugInitialized=0
  " I know that all these could be replaced with just the git one. But I don't want to delete them
  if executable("curl")
    silent exec '!curl -fLo ' . shellescape(expand(g:vimDirectory."/autoload/plug.vim")) .
        \ ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  " If all else fails we can just use git.
  elseif executable("git")
    silent exec '!git clone -q --depth=1 git@github.com:junegunn/vim-plug.git ' . shellescape(expand(g:vimDirectory."/temp"))
    if has('gui_win32')
      let s:mv="move "
      let s:rm="del "
    else
      let s:mv="mv "
      let s:rm="rm -rf "
    endif
    silent exec '!' . s:mv . shellescape(expand(g:vimDirectory."/temp/plug.vim")) .
      \ ' ' . shellescape(expand(g:vimDirectory."/autoload/plug.vim"))
    silent exec '!' . s:rm . shellescape(expand(g:vimDirectory."/temp/"))
  else
    echo "Couldn't find a way to download Vim-Plug. Not sure how you were planning" .
      \ " installing plugins without Git."
  endif

  if has('nvim')
    " Install python client
    if HasExec('pip')
      silent exec '!pip install neovim'
    endif
    if HasExec('pip3')
      silent exec '!pip3 install neovim'
    endif
  endif
  function! InstallMyPlugs() abort
    PlugInstall
    if has('nvim')
      UpdateRemotePlugins
    endif
  endfunction
  augroup PluginInstallation
    autocmd!
    autocmd VimEnter * call InstallMyPlugs()
  augroup END
endif
" }

" Plugin Declarations: {
call plug#begin(g:vimDirectoryPart . 'bundle')

"Add your plugins here
" Games: {
Plug 'vim-scripts/TeTrIs.vim'
Plug 'johngrib/vim-game-code-break', { 'on': 'VimGameCodeBreak' }
" }
" Git: {
" Commands for using git nicely in Vim
" Vim Fugitive: {
" Always load
" NOTE: fugitive makes vim very laggy sometimes
Plug 'tpope/vim-fugitive'
" Search the word under the cursor with `git grep`.
" Result locations are put into quickfix.
" https://statico.github.io/vim3.html
if HasExec('git')
  nmap <leader>gk :Ggrep! "\b<cword>\b" <CR>
  " View staged changes
  command Greview :Git! diff --staged
endif
" }
if HasExec('git')
  " Commit browser. Switch to original (junegunn/gv.vim) after it merges help PR
  Plug 'sudavid4/gv.vim', { 'on': 'GV' }
  " Show git changes in gutter
  " Vim GitGutter: {
  Plug 'airblade/vim-gitgutter'
  " Tell gitgutter not to set any keybinds by itself. They will all be rebound.
  let g:gitgutter_map_keys = 0
  " Move from to the next/prev change
  nmap ]g <Plug>GitGutterNextHunk
  nmap [g <Plug>GitGutterPrevHunk
  " Stage or revert the lines the cursor is on
  nmap <Leader>gs <Plug>GitGutterStageHunk
  nmap <Leader>gr <Plug>GitGutterRevertHunk
  " Preview the changes
  nmap <Leader>gp <Plug>GitGutterPreviewHunk
  let g:gitgutter_eager = 0
  " }
endif
" }
""" Auto Formatting:
" AutoPairs: {
Plug 'jiangmiao/auto-pairs'
let s:autoPairsMapCh=0
let s:autoPairsMapBS=0
" }
Plug 'Konfekt/FastFold'
" Syntax: {
" FileType Specific: (syntax files) {
" General language pack
Plug 'sheerun/vim-polyglot'
" Go: {
function! InstallGoBins(info) abort
  if a:info.status == 'installed'
    GoInstallBinaries
  elseif a:info.status == 'updated'
    GoUpdateBinaries
  endif
endfunction
" VimGo: {
if HasExec('go') && empty($SIMPLE_VIM_PLUGINS)
  Plug 'fatih/vim-go', { 'do': function('InstallGoBins')}
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.go =
    \ '\h\w*\|[^. \t]\.\w*'
  if HasExec("goimports")
    let g:go_fmt_command = "goimports"
    if has("win32")
      let g:go_fmt_command = "goimports.exe"
    endif
  endif
endif
" }
" }

Plug 'rust-lang/rust.vim'
" Some more concealchars for tex
Plug 'KeitaNakamura/tex-conceal.vim'
" VimPandoc: {
if HasExec('pandoc') && empty($SIMPLE_VIM_PLUGINS)
  Plug 'vim-pandoc/vim-pandoc'
  let g:pandoc#keyboard#use_default_mappings = 0
endif
" }
" VimPandocSyntax: {
Plug 'vim-pandoc/vim-pandoc-syntax'
if !HasExec('pandoc')
  augroup PandocSyntaxFT
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.pdc set filetype=pandoc
    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
endif
" }
if HasExec('python') && empty($SIMPLE_VIM_PLUGINS)
  Plug 'davidhalter/jedi-vim'
endif
Plug 'vim-scripts/csv.vim', {'for': 'csv'}
Plug '2072/php-indenting-for-vim'
" Adds syntax highlighting for some keywords in React. vim-polyglot already provides JSX syntax.
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }

" Helpers for creating comments
" JCommenter: {
Plug 'AdnoC/jcommenter.vim', { 'for': 'java'}
" }
" VimJSDoc: {
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript'}
let g:jsdoc_allow_input_prompt=1
let g:jsdoc_additional_descriptions=1
let g:jsdoc_default_mapping=0

augroup VIMJSDOC
  autocmd!
  autocmd FileType javascript nmap <leader>cj :JsDoc<CR>
augroup END
" }


" Add docs for Java on 'J' keybind
Plug 'davetron5000/javax-xml-javadoc-vim', { 'for': 'java'}
Plug 'davetron5000/javax-javadoc-vim', { 'for': 'java'}
Plug 'davetron5000/java-javadoc-vim', { 'for': 'java'}
" }
if !&diff
  if (has('nvim') || v:version >= 8)
    " Neomake: {
    let g:syntax_plugin = s:syntax_neomake
    Plug 'neomake/neomake'

    nnoremap <leader><ENTER> :Neomake<CR>
    " autocmd! BufWritePost * Neomake

    " Use gcc by default
    let g:neomake_cpp_enabled_makers = ['gcc']
    " Use different gcc args
    " Open location list when errors occur
    " Preserve cursor position
    let g:neomake_open_list = 2
    " Highlight lines with errors
    let g:neomake_highlight_lines=1

    augroup NeomakeErrorSigns
      au!
      autocmd ColorScheme *
            \ hi NeomakeErrorSign ctermfg=124
    augroup END
    " }
  else
    " Syntastic: {
    let g:syntax_plugin = s:syntax_syntastic
    Plug 'scrooloose/syntastic'
    " Turn it on by default, so far no filetypes where it needs to be off.
    " let g:syntastic_mode_map = { 'mode': 'active',
    "   \ 'active_filetypes': [],
    "   \ 'passive_filetypes': ['java'] }
    " Bind a button to check syntax when in passive mode
    augroup JavaSyntastic
      autocmd!
      autocmd FileType java nnoremap <leader>cc :SyntasticCheck<CR>
    augroup END
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
    let g:syntastic_cpp_compiler_options = ' -std=c++14'
    " Shortcuts to prev/next errors
    let g:syntastic_java_javac_config_file_enabled = 1
    let g:syntastic_javascript_checkers = ['eslint']
    let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'
    " }
  endif
else
  let g:syntax_plugin = ''
endif
" Set indent options based on what is used in the file
" Plug 'tpope/vim-sleuth'
" Auto-close some structures (i.e. adds 'endfunction' after
" you type 'function!' in VimL)
" Endwise: {
let g:endwise_no_mappings = 1
Plug 'tpope/vim-endwise'
" }
" Indent Lines: {
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesToggle'}
let g:indentLine_enabled=0
" The default bind, just here so I remember
nnoremap <leader>ig :IndentLinesToggle<CR>
" }

" NeoSnippet: {
if empty($SIMPLE_VIM_PLUGINS)
  Plug 'Shougo/neosnippet.vim'| Plug 'Shougo/neosnippet-snippets'

  imap <C-j>     <Plug>(neosnippet_expand_or_jump)
  smap <C-j>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-j>     <Plug>(neosnippet_expand_target)
  " Show list of snippets when nothing has been typed
  inoremap <silent> <c-u> <c-r>=cm#sources#neosnippet#trigger_or_popup("\<Plug>(neosnippet_expand_or_jump)")<cr>
endif
let g:neosnippet#enable_completed_snippet=1
" }

" Autocomplete: {
" Omnisharp: {
if empty($SIMPLE_VIM_PLUGINS) && HasExec('msbuild')
  Plug 'OmniSharp/Omnisharp-vim', { 'do': 'msbuild' }
  let g:OmniSharp_selector_ui = 'fzf'
  augroup CSharpIDEBinds
    autocmd!
    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap K :OmniSharpDocumentation<CR>
  augroup END
endif
" }
" YouCompleteMe only works on Linux/Mac and if vim is version > 7.3.584
" Use supertab if YCM won't work
if !empty($STANDALONE_VIM_PLUGINS)
  let g:autocomplete_plugin = g:autocomplete_supertab
  Plug 'ervandew/supertab'
elseif has('nvim')
    let g:autocomplete_plugin = g:autocomplete_ncm
  Plug 'roxma/nvim-completion-manager'
  if HasExec('clang')
    Plug 'roxma/ncm-clang'
  endif
  if HasExec('racer')
    Plug 'roxma/nvim-cm-racer'
  endif

elseif (has('lua') || has('nvim'))
  if has('nvim')
    " Deoplete: {
    let g:autocomplete_plugin = g:autocomplete_deoplete
    Plug 'Shougo/deoplete.nvim'
    "" Run deoplete.nvim automatically
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#auto_complete_start_length=1
    let g:deoplete#max_menu_width = 500
    let g:deoplete#max_abbr_width = 500
    let g:deoplete#sources = {}
    let g:deoplete#ignore_sources = {}
    " let g:deoplete#ignore_sources.cpp = ['buffer', 'syntax']
    " let g:deoplete#ignore_sources.rust = ["buffer", "member", "tag", "file", "omni", "dictionary", "around"]
    " let g:deoplete#ignore_sources.javascript = ["buffer", "member", "tag", "file", "omni", "dictionary", "around", "flow", "syntax"]
    " let g:deoplete#ignore_sources.javascript = ["flow", "omni", "ternjs"]
    let g:deoplete#ignore_sources.javascript = ["omni", "flow"]
    let g:deoplete#ignore_sources.go = ["buffer", "syntax"]
    " }
  else
    " Neocomplete: {
    let g:autocomplete_plugin = g:autocomplete_neocomplete
    Plug 'Shougo/neocomplete.vim'
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#auto_complete_start_length=1
    let g:neocomplete#enable_smart_case = 1
    " }
  endif

  if HasExec('clang')
    " NOTE: deoplete-clang needs to point to clang's dynamic library, not just
    " where it can find the library
    " if (g:autocomplete_plugin == g:autocomplete_deoplete &&
    "       \ !empty($CLANG_INCLUDE_PATH) && !isdirectory($LIBCLANG_PATH))
      " Plug 'zchee/deoplete-clang'
    if g:autocomplete_plugin == g:autocomplete_deoplete
      " DeopleteClang: {
      Plug'tweekmonster/deoplete-clang2'
      " let g:deoplete#sources#clang#libclang_path = $LIBCLANG_PATH
      " let g:deoplete#sources#clang#clang_header = $CLANG_INCLUDE_PATH
      " }
    elseif !empty($LIBCLANG_PATH)
      " ClangComplete: {
      Plug 'Rip-Rip/clang_complete'
      let s:clang_library_path = $LIBCLANG_PATH
      if ((!has('nvim') || !empty($CLANG_INCLUDE_PATH)) && !isdirectory(s:clang_library_path))
        let s:clang_library_path = fnamemodify(s:clang_library_path, ':h')
      endif
      let g:clang_library_path = s:clang_library_path
      let g:clang2_placeholder_next = '<c-k>'
      let g:clang2_placeholder_prev = '<c-j>'
      " }
    endif
  elseif VimPlugInitialized == 0
    echo 'Cannot find clang, not installing clang completion'
  endif

  if HasExec('ternjs')
    if g:autocomplete_plugin == g:autocomplete_deoplete
      " DeopleteTernjs: {
      Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript'}
      let g:deoplete#sources#ternjs#tern_bin = 'ternjs'
      let g:deoplete#sources#ternjs#filetypes = [
                      \ 'jsx',
                      \ 'javascript.jsx',
                      \ 'vue',
                      \ ]
      let g:deoplete#sources#ternjs#types = 1
      let g:deoplete#sources#ternjs#docs = 1
      " }
    else
      " TernForVim: {
      Plug 'ternjs/tern_for_vim'
      let g:tern_show_signature_in_pum = 1
      let g:tern#filetypes = [
                      \ 'jsx',
                      \ 'javascript.jsx',
                      \ ]
      " Make neocomplete understand that we are getting syntax info from tern
      if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
      endif
      let g:neocomplete#sources#omni#input_patterns.javascript =
        \ '\h\w*\|[^. \t]\.\w*'
      " }
    endif
  elseif VimPlugInitialized == 0
    echo 'Cannot find tern, not installing javascript completion'
  endif

  if HasExec('flow')
    if g:autocomplete_plugin == g:autocomplete_deoplete
      Plug 'steelsojka/deoplete-flow', { 'for': 'javascript'}
    endif
  endif

" DeopleteGo: {
  if HasExec('gocode')
    if g:autocomplete_plugin == g:autocomplete_deoplete
      Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go'}
      augroup DeoGoMore
        autocmd!
        autocmd FileType go call deoplete#custom#set('go', 'rank', 9999)
      augroup END
      let g:deoplete#sources#go#align_class = 1
      if has('win32')
        let g:deoplete#sources#go#gocode_binary = expand($GOPATH.'/bin/gocode.exe')
      endif
    endif
  elseif VimPlugInitialized == 0
    echo 'Cannot find gocode, not installing go completion'
  endif
" }

  if HasExec('msbuild')
    if g:autocomplete_plugin == g:autocomplete_deoplete
      Plug 'dimixar/deoplete-omnisharp'
    endif
  endif

  if HasExec('python')
    if g:autocomplete_plugin == g:autocomplete_deoplete
      Plug 'zchee/deoplete-jedi', { 'for': 'python'}
    endif
  endif

  " Vim autocomplete. Uncomment when you have something for it.
  " Plug 'Shougo/neco-vim'

  " File completion
  Plug 'Shougo/neoinclude.vim'

  " Syntx-based autocomplete TODO: Figure out if this is useful
  Plug 'Shougo/neco-syntax'

else
  let g:autocomplete_plugin = g:autocomplete_ycm
  " If we have a new enough version of cmake, use upsteam
  let g:ycmInstallCommand = "/install.py --clang-completer --tern-completer --go-completer"
  Plug 'Valloric/YouCompleteMe', { 'do': g:ycmInstallCommand}
        \ | Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
endif
" Echodoc: {
" Show function signature for auto-completed functions
Plug 'Shougo/echodoc.vim'
let g:echodoc_enable_at_startup = 1
" }

" VimRacer: {
if empty($SIMPLE_VIM_PLUGINS)
  if HasExec('racer')
    Plug 'racer-rust/vim-racer'
    let g:racer_experimental_completer = 1
  elseif (VimPlugInitialized == 0 && HasExec('cargo'))
    silent exec '!cargo install racer'
  endif
endif
" }
" }

" }
" Tools: {
" Nice startup screen
Plug 'mhinz/vim-startify'
" Sources a .lvimrc file to allow for per-project configuration
" Vim_LocalVimrc: {
Plug 'embear/vim-localvimrc'
let g:localvimrc_persistent = 2
" }
" Shows all 256 x-term colors in a nice table
Plug 'guns/xterm-color-table.vim'
" Fixes <C-A> and <C-X> to correctly increment/decrement dates
Plug 'tpope/vim-speeddating'
" Makes ga show additional info about a character
" Characterize: {
Plug 'tpope/vim-characterize'
nmap gch <Plug>(characterize)
" }
" Shows (vim) syntax info as well as color of stuff.
" SyntaxAttr: {
Plug 'vim-scripts/SyntaxAttr.vim'
nmap <leader>a :call SyntaxAttr()<CR>
" }
" Commands for using unix commands nicely in Vim
Plug 'tpope/vim-eunuch'
" Close buffers without closing windows
" BufKill: {
Plug 'qpkorr/vim-bufkill'
let g:BufKillCreateMappings=0
" }
" TComment: {
Plug 'tomtom/tcomment_vim'
let g:tcommentGuessFileType_php = "php"
" }
" File Explorer Plugin
Plug 'jeetsukumaran/vim-filebeagle'
" UndoTree: {
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
" Bind a button to open UntoDree
nnoremap <leader>gu :UndotreeToggle<CR>
" }
" Fuzzy search for files, buffers, and recent files
if empty($STANDALONE_VIM_PLUGINS) && empty($SIMPLE_VIM_PLUGINS)
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  let g:fzf_command_prefix="Fzf"
  nmap <leader>p :FZF<CR>
  nmap <leader>b :FzfBuffers<CR>
  nmap <leader>t :FzfBTags<CR>
  augroup JavascriptFZF
    autocmd!
    autocmd FileType javascript command! -buffer -bang -nargs=* FzfBTags
      \ call fzf#vim#buffer_tags(<q-args>,
      \ [printf('jsctags %s -f', expand('%:S'))],
      \ <bang>0 ? {} : copy(get(g:, 'fzf_layout', g:fzf#vim#default_layout)))
        " \ printf('ctags -f - --sort=no --excmd=number --language-force=%s %s', &filetype, expand('%:S')),
        " \ printf('ctags -f - --sort=no --excmd=number %s', expand('%:S'))], {})
  augroup END
else
  Plug 'ctrlpvim/ctrlp.vim'
  nnoremap <leader>p :CtrlP<CR>
endif
" Align text
Plug 'tommcdo/vim-lion'

Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-user'
" Gutentags: {
if HasExec('ctags')
  " Auto-generate tag files
  Plug 'ludovicchabant/vim-gutentags'
  nnoremap <leader>gt :GutentagsUpdate<CR>
  let g:gutentags_ctags_exclude = ['node_modules']
endif
" }
if HasExec('cscope')
  Plug 'chazy/cscope_maps'
endif
" }
" Text Objects: {
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
" TextobjComment: {
Plug 'glts/vim-textobj-comment'
let g:textobj_comment_no_default_key_mappings = 1
xmap ax <Plug>(textobj-comment-a)
omap ax <Plug>(textobj-comment-a)
xmap ix <Plug>(textobj-comment-i)
omap ix <Plug>(textobj-comment-i)
xmap aX <Plug>(textobj-comment-big-a)
omap aX <Plug>(textobj-comment-big-a)
xmap iX <Plug>(textobj-comment-big-i)
omap iX <Plug>(textobj-comment-big-i)
" }
" }
" Looks: {
" Colorschemes
" A good solarized replacement. Has a grey background unless bash colors are overritten.
Plug 'romainl/flattened'
" A light colorscheme. Not sure about it.
Plug 'NLKNguyen/papercolor-theme'
" VimColorsSolarized: {
Plug 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_visibility='high'
" }
Plug 'lifepillar/vim-solarized8'
" Makes the status bar & buffer bar look nice and display useful info
if empty($SIMPLE_VIM_PLUGINS)
  " Vim Airline: {
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  if g:syntax_plugin == s:syntax_syntastic
    let g:airline#extensions#syntastic#enabled = 1
  elseif g:syntax_plugin == s:syntax_neomake
    let g:airline#extensions#neomake#enabled = 1
  endif
  " Show a list of files on the top of the screen
  let g:airline#extensions#tabline#enabled = 1
  " let g:airline#extensions#tabline#buffer_nr_show = 1
  let s:tablineBuffWidth = winwidth(0) / 5
  if s:tablineBuffWidth < 20
    let s:tablineBuffWidth = 20
  endif
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  let g:airline#extensions#tabline#tab_nr_type = 2

  let g:airline#extensions#tabline#show_tab_type = 1

  " Set the theme to solarized
  if !exists('g:airline_theme')
    let g:airline_theme = 'solarized'
  endif
  " Use fancy fonts
  if g:autocomplete_plugin == g:autocomplete_ycm && $UPSTREAM_YCM == 0
    let g:airline_powerline_fonts = 0
  else
    let g:airline_powerline_fonts = 1
  endif

  " Only show git stats that are non-zero
  let g:airline#extensions#hunks#non_zero_only=1
  if HasExec('tmux')
    " Don't load tmuxline unless I decide to. It adds 1000ms to startuptime
    let g:airline#extensions#tmuxline#enabled=0
  endif
  " Clean up the status bar:
  " Just show the list of files/buffers in section c
  let g:airline_section_c = "%f%m %<%{bufname('#') != bufname('%') ? '('. bufname('#') .')' : ''}"
  " Also don't need to know the formatting. Just leave it empty
  let g:airline_section_x=''
  " Automatically refresh airline when changing colorschemes. This fixes the arrows.
  augroup RefreshAirline
    autocmd!
    autocmd VimEnter * autocmd ColorScheme * AirlineRefresh
  augroup END
  " }
else
  Plug 'bling/vim-bufferline'
endif
" Dims paragraphs besides the one you are working on
" Limelight: {
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
let g:limelight_conceal_ctermfg = 'DarkGray'
" }
" Removes distractions
" Goyo: {
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
augroup GoyoLimelight
  autocmd!
  autocmd User GoyoEnter Limelight
  autocmd User GoyoLeave Limelight!
augroup END
" }
" }
" Movement: {
" Plug 'wikitopian/hardmode'
" VimOperatorSurround: {
Plug 'rhysd/vim-operator-surround'
" operator mappings
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sc <Plug>(operator-surround-replace)
" }
" Lets you replace text with something from a register (like pasting from register)
" VimOperatorReplace: {
Plug 'kana/vim-operator-replace'
map <silent><leader>re <Plug>(operator-replace)
" }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
" matchit breaks [] jumping. Only use it when 100% useful
Plug 'k-takata/matchit.vim'
" }


" Tagbar: {
" Ctags are a dependancy of tagbar
if HasExec('ctags')
  Plug 'majutsushi/tagbar'
  " Bind a button to open the tagbar
  nnoremap <leader>cb :TagbarToggle<CR>
  let g:tagbar_autoclose=1
  let g:tagbar_autofocus=1

  if HasExec('php') && !has('win32')
    " Plug 'vim-php/phpctags'
    Plug 'vim-php/tagbar-phpctags.vim', { 'do': 'make'}
  endif
else
  if VimPlugInitialized == 0
    echo 'Cannot find ctags. Not installing tagbar.'
  endif
endif
" }

" Tmux: {
if HasExec('tmux')
  " Lets you use <C-hjkl> to move between both tmux and vim panes.
  " VimTmuxNavigator: {
  Plug 'christoomey/vim-tmux-navigator'
  if has('nvim')
    " A hackey solution to C-h not working
    nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
  endif
  " }
  " Vimux: {
  Plug 'benmills/vimux'
  noremap <leader>vp :VimuxPromptCommand<CR>
  noremap <leader>vr :VimuxRunLastCommand<CR>
  noremap <leader>vo :VimuxInspectRunner<CR>
  noremap <leader>vc :VimuxCloseRunner<CR>
  " }
  Plug 'edkolev/tmuxline.vim', { 'on': ['Tmuxline', 'TmuxlineSnapshot'] }
else
  if VimPlugInitialized == 0
    echo 'Cannot find tmux. Not installing vimux or tmuxline'
  endif
endif
" }
" W3M: {
if HasExec('w3m')
  Plug 'yuratomo/w3m.vim'
  " Bind w3m to an easy key and add http so it doesn't search.
  nnoremap <leader>w3 :W3m http://
  augroup W3mStuff
    autocmd!
    autocmd FileType w3m setlocal colorcolumn=
    autocmd FileType w3m setlocal scrolloff=3
    autocmd FileType w3m nnoremap <buffer>q :W3mClose<CR>
    autocmd FileType w3m nnoremap <buffer>o :W3mAddressBar<CR>
    " Shift j/k scrolls down/up
    autocmd FileType w3m nnoremap <buffer><S-j> <C-e>
    autocmd FileType w3m nnoremap <buffer><S-k> <C-y>
  augroup END
elseif VimPlugInitialized == 0
  echo 'Cannot find W3m. Not installing w3m.vim'
endif
" }

call plug#end()
" }

    "...All your other bundles...
"if VimPlugInitialized == 0
  "echo "Installing Plugins, please ignore key map error messages"
  "echo ""
"endif

" Vimballs: {
" Installs all vimballs in the vimball directory
function! InstallVimballs() abort
  " For each file in the vimball diretcory...
  for f in split(glob(expand(g:vimDirectory . '/vimball/') . "*"))
    " Open the file in a new buffer
    exec 'new' f
    " Source the buffer
    source %
    " Then close the buffer
    bwipe
  endfor
endfunction
" }

" If we are in a new installation and therefore are installing plugins...
if VimPlugInitialized == 0
  echo "Intalling Vimballs"
  " Intall vimballs (UseVimball needs to be called after startup, therefore au)
  augroup VimballInstall
    autocmd!
    autocmd VimEnter * call InstallVimballs()
  augroup END
endif

" Plugin Settings: (Function calls) {

" Neomake: {
if g:syntax_plugin == s:syntax_neomake
  try
    let g:neomake_cpp_gcc_maker = neomake#makers#ft#cpp#gcc()
    let g:neomake_cpp_gcc_maker.args = g:neomake_cpp_gcc_maker.args
          \ + ['-std=c++14', '-Wall', '-Werror', '-Wextra', '-pedantic']
    let g:neomake_cpp_clang_maker = neomake#makers#ft#cpp#clang()
    let g:neomake_cpp_clang_maker.args = g:neomake_cpp_clang_maker.args
          \ + ['-std=c++14', '-Wall', '-Werror', '-Wextra', '-pedantic']
  catch
  endtry
endif
" }

" General Completion: {
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" }

" Deoplete: {
if g:autocomplete_plugin == g:autocomplete_deoplete
  try
    call deoplete#custom#source('_', 'converters',
          \ ['converter_remove_paren'])
  catch
  endtry
endif
" }

" Vim Airline: {
if empty($SIMPLE_VIM_PLUGINS)
  " No need for tagbar if we don't have ctags. Also don't call functions if the plugin isn't installed.
  if HasExec('ctags') && VimPlugInitialized == 1
    " No need to show filetype in the status bar, the ctags section is enough
    " autocmd User AirlineAfterInit let g:airline_section_y = airline#section#create(['tagbar'])
    try
      let g:airline_section_y = airline#section#create(['tagbar'])
    catch
    endtry
  endif
endif
" }

" PreserveNoEOL:
let g:PreserveNoEOL=1

" PIV: {
" Don't let it map, because it causes ',' to hava a delay
let g:PIVCreateDefaultMappings = 0
" AutoPHPFolding really hits performance, making cursor movement and switching bufers laggy
let g:DisableAutoPHPFolding = 1
" }

" Custom operator comment (UNUSED) {
" Using vim-operator-user (With NERDCommenter)
" http://relaxedcolumn.blog8.fc2.com/blog-entry-154.html
" Get SID prefix of vimrc (see :h <SID>)
" function! s:SID_PREFIX() abort
"     return matchstr(expand('<sfile>'), '<SNR>\d\+_')
" endfunction
"function! s:setCommentOperator(key, name) abort
    "call operator#user#define(
    "\   'comment-' . a:name,
    "\   s:SID_PREFIX() . 'doCommentCommand',
    "\   'call ' . s:SID_PREFIX() . 'setCommentCommand("' . a:name . '")')
    "execute 'map' a:key '<Plug>(operator-comment-' . a:name . ')'
"endfunction

"function! s:setCommentCommand(command) abort
    "let s:comment_command = a:command
"endfunction

"function! s:doCommentCommand(motion_wiseness) abort
    "let v = operator#user#visual_command_from_wise_name(a:motion_wiseness)
    "execute 'normal! `[' . v . "`]\<Esc>"
    "echo s:comment_command
    "call NERDComment('x', s:comment_command)
"endfunction

"call s:setCommentOperator('<leader>cv', 'comment')
"call s:setCommentOperator('<leader>cx', 'uncomment')
" }

" }


" Chained Keybinds: {
" Sometimes multiple plugins want to use the same key, or mapping them in
" a certain order causes things act funny.
" This section is for mapping those cases.

" Enter: {
" Make sure that <CR> at least has itself in the mapping
if mapcheck('<CR>', 'i') == ""
    let s:old_enter_arg1 = "\<CR>"
  inoremap <silent><CR> <CR>
else
  " This doesn't work
  let s:old_enter_arg1 = maparg('<CR>', 'i')
endif

" Autocompletes:
if empty($SIMPLE_VIM_PLUGINS)
  " Close the completion popup if it is visible. If it is not, press Enter.
  " Deoplete:
  if g:autocomplete_plugin == g:autocomplete_deoplete
    imap <silent><CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function() abort
      let cr_str = pumvisible() ? "" : "\<CR>"
      return deoplete#close_popup() . cr_str
      " return (pumvisible() ? "\<C-y>" : "" ) . "\<Plug>AutoPairsReturn"
    endfunction
  " NCM:
  elseif g:autocomplete_plugin == g:autocomplete_ncm
    imap <silent><CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function() abort
      " return pumvisible() ? "\<c-y>\<CR>" : "\<CR>"
      return pumvisible() ? "\<c-y>" . s:old_enter_arg1 : s:old_enter_arg1
    endfunction

  " Neocomplete:
  elseif g:autocomplete_plugin == g:autocomplete_neocomplete
    imap <silent><CR> <C-r>=<SID>my_cr_function()<CR>

    function! s:my_cr_function() abort
      let cr_str = pumvisible() ? "" : "\<CR>"
      return neocomplete#close_popup() . cr_str
    endfunction
  endif
endif

" Endwise:
exe "imap <silent><CR> ".maparg('<CR>','i')."<Plug>DiscretionaryEnd"
" }

" CtrlH: {
" Deoplete:
if empty($SIMPLE_VIM_PLUGINS)
  if has('nvim')
    imap <silent><C-h> <C-r>=deoplete#smart_close_popup()<CR>

    " Neocomplete:
  else
    imap <silent><C-h> <C-r>=neocomplete#smart_close_popup()<CR>
  endif
endif

" Make sure that <c-h> at least has itself in the mapping
if !mapcheck('<c-h>', 'i')
  imap <silent><c-h> <c-h>
endif
" AutoPairs:
exe "imap <silent><C-h> ".maparg('<C-h>', 'i')."<C-r>=AutoPairsDelete()<CR>"
" }

" Backspace: {
" Deoplete:
if empty($SIMPLE_VIM_PLUGINS)
  if has('nvim')
    imap <silent><BS> <C-r>=deoplete#smart_close_popup()<CR>

    " Neocomplete:
  else
    imap <silent><BS> <C-r>=neocomplete#smart_close_popup()<CR>
  endif
endif

" Make sure that <BS> at least has itself in the mapping
if !mapcheck('<BS>', 'i')
  imap <silent><BS> <BS>
endif
" AutoPairs:
exe "imap <silent><BS> ".maparg('<BS>', 'i')."<C-r>=AutoPairsDelete()<CR>"
" }
" }

" vim: foldmethod=marker foldmarker={,}
