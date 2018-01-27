" Pandoc {
" Workaround for lack of timer_create in WSL
if !empty($IN_WSL)
  let s:pandocCmd="pandoc\\ +RTS\\ -V0\\ -RTS"
  let s:pandocPDFCmd="pandoc +RTS -V0 -RTS"
else
  let s:pandocCmd="pandoc"
  let s:pandocPDFCmd="pandoc"
endif

function! ViewPandoc() abort
  " Pass the html output to w3m
  exec "!cat " . expand('%:h') . expand('/') . ".PandocOutput" .
        \ expand('/') . expand('%:r') . ".html \| w3m -T text/html"
endfunction

function! PandocMakePDF() abort
  exec "!" . s:pandocPDFCmd . " --highlight-style=pygments -s --output=\"" .
        \ expand('%:h') . expand('/') . ".PandocOutput" . expand('/') .
        \ expand('%:r') . ".pdf\" %"
endfunction


if ! isdirectory('.PandocOutput')
  exec "!mkdir .PandocOutput"
endif


exec "setlocal makeprg=" . s:pandocCmd .
      \ "\\ --highlight-style=pygments\\ -s\\ --output=\\\"" .
      \ expand('%:h') . expand('/') . ".PandocOutput" . expand('/') .
      \ expand('%:r') . ".html\\\"\\ %"


command! -nargs=0 -buffer ViewPandoc call ViewPandoc()
command! -nargs=0 -buffer PandocMakePDF call PandocMakePDF()

if HasExec('pandoc') && empty($SIMPLE_VIM_PLUGINS)
  nmap <buffer>go <Plug>(pandoc-keyboard-links-open)
  nmap <buffer>gb <Plug>(pandoc-keyboard-links-back)
endif

" Turn spellcheck off because we are going to be using words that aren't in the dictionary
setlocal nospell
" Use 4 spaces per tab since thats the magic number for pandoc
setlocal shiftwidth=4
" Don't add '*' or '#' after newline
setlocal formatoptions-=r
setlocal formatoptions-=o
" }

" vim: foldmethod=marker foldmarker={,}
