let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '`':'`'}

if HasExec('racer')
  nmap gd <Plug>(rust-def)
  nmap gs <Plug>(rust-def-split)
  nmap gx <Plug>(rust-def-vertical)
  nmap <leader>gd <Plug>(rust-doc)
  nmap K <Plug>(rust-doc)

  " if g:autocomplete_plugin == g:autocomplete_deoplete
  "   call deoplete#custom#set('racer', 'rank', 9999)
  " endif
endif
