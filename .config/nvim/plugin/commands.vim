function! ToggleCursorLine()
    if (bufname("%") =~ "NerdTree")
        setlocal cursorline
    else
        setlocal nocursorline
    endif
endfunction

