setlocal foldmethod=expr
setlocal tabstop=2
setlocal shiftwidth=2
nnoremap <silent> <f3> :w<cr> :!g++ -Wall -O2 -std=c++2a -DDEBUG % -o %:r<cr>
nnoremap <silent> <f4> :w<cr> :!./%:r<cr>
nnoremap <silent> <f5> :w<cr> :!g++ -Wall -O2 -std=c++2a -DDEBUG % -o %:r<cr> :!./%:r<cr>
