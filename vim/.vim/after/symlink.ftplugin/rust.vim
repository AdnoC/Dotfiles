let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '`':'`'}

if HasExec('racer') && g:autocomplete_plugin != g:autocomplete_coc
  nmap <buffer>gd <Plug>(rust-def)
  nmap <buffer>gs <Plug>(rust-def-split)
  nmap <buffer>gx <Plug>(rust-def-vertical)
  nmap <buffer><leader>gd <Plug>(rust-doc)
  nmap <buffer>K <Plug>(rust-doc)

  " if g:autocomplete_plugin == g:autocomplete_deoplete
  "   call deoplete#custom#set('racer', 'rank', 9999)
  " endif
endif
