let s:filetype_zeal = {
            \ 'c': 'C',
            \ 'cpp': 'C++',
            \ 'css': 'Css',
            \ 'html': 'Html',
            \ 'java': 'Java',
            \ 'js': 'Javascript',
            \ 'markdown': 'Markdown',
            \ 'md': 'Markdown',
            \ 'mdown': 'Markdown',
            \ 'mkd': 'Markdown',
            \ 'mkdn': 'Markdown',
            \ 'php': 'Php',
            \ 'py': 'Python',
            \ 'scss': 'sass',
            \ 'sh': 'Bash',
            \ 'tex': 'Latex',
            \ }

if has('win32') || has('win64')
    let s:zeal_pre = "start C:/zeal/zeal.exe"
    let s:zeal_post = ""
else
    let s:zeal_pre = "zeal"
    let s:zeal_post = " &"
endif

function! GetDocset()
    if has_key(s:filetype_zeal, &filetype) == 1
        let docset = s:filetype_zeal[&filetype]
    else
        let docset = &filetype
    endif
    return docset
endfunction

" Gets the docset by the current docset and the word
" e.g.: Qt and c++ (all keywords start with 'Q')
function! GetDocsetWord(docset, word)
    if ((a:docset == "C++") || (a:docset == "C")) && (match(a:word, "Q") >= 0)
        return 'Qt'
    elseif a:docset == "Javascript"
        let line = getline('.')[0:virtcol('.')]
        if (match(line, '\m\$') > 0)
            return 'jQuery'
        endif
    endif
    return a:docset
endfunction

function! RunZeal(docset, word)
    execute ":silent !".s:zeal_pre." --query ".a:docset.":".a:word.s:zeal_post
    redraw!
endfunction

function! RunZealUnderCursor()
    let word = expand("<cword>")
    let docset = GetDocset()
    let docset = GetDocsetWord(docset, word)
    call RunZeal(docset, word)
endfunction

function! RunZealWord(word)
    let docset = GetDocset()
    let docset = GetDocsetWord(docset)
    call RunZeal(docset, a:word)
endfunction

nnoremap <leader>z :call RunZealUnderCursor()<cr>
