setlocal foldmethod=expr
setlocal tabstop=4
setlocal shiftwidth=4
nnoremap <silent> <f3> :w<cr> :!g++ -O0 -fsyntax-only -std=c++2a %<cr>
nnoremap <silent> <f4> :w<cr> :!a.out ^& %<cr>
nnoremap <silent> <f5> :w<cr> :!g++ -O2 -std=c++2a %<cr> :!./a.out<cr>
