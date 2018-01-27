if executable('ant')
    setlocal makeprg=ant\ -find\ 'build.xml'
    compiler ant
    setlocal shellpipe=2>&1\ \|\ tee
endif

let g:jcommenter_method_description_space = 1
" Set author config
let b:jcommenter_class_author='Adam Cutler'
let b:jcommenter_file_author='Adam Cutler'
" Create a bind to generate comments
nmap <leader>cj :call JCommentWriter()<CR>
nmap <leader>c] :call SearchInvalidComment(0)<cr>
nmap <leader>c[ :call SearchInvalidComment(1)<cr>
