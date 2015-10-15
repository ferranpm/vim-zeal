if exists("zeal_loaded") || &compatible
    finish
endif
let zeal_loaded = 1

if !exists("g:zeal_exec")
    if has('win32') || has('win64')
        let g:zeal_exec = "C:/zeal/zeal.exe"
    else
        let g:zeal_exec = "zeal"
    endif
endif

nnoremap <leader>z :call zeal#RunZealUnderCursor()<cr>
