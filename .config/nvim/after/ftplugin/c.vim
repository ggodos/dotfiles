setlocal foldmethod=expr
setlocal tabstop=4
setlocal shiftwidth=4
nnoremap <silent> <f3> :w<cr> :!gcc -Wall -O2 -std=c99 -DDEBUG % -o %:r<cr>
nnoremap <silent> <f4> :w<cr> :!./%:r<cr>
nnoremap <silent> <f5> :w<cr> :!gcc -Wall -O2 -std=c99 -DDEBUG % -o %:r<cr> :!./%:r<cr>

" nnoremap <silent> <f3> :!gcc -O0 -fsyntax-only %<cr>
" nnoremap <silent> <f4> :!./a.out %<cr>
" nnoremap <silent> <f5> :!gcc -O2 %<cr> :!./a.out %<cr>
