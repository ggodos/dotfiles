setlocal foldmethod=expr
setlocal tabstop=4
setlocal shiftwidth=4
nnoremap <f5> :w <bar> !javac % && java %:r <cr>
