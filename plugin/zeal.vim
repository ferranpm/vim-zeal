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

function! RunZeal(docset, word)
    " execute '!zeal --query ' a:docset.':'.a:word
    execute ":!zeal --query '".a:docset.":".a:word."'&"
endfunction

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
    if ((a:docset == "C++") || (a:docset == "C")) &&
        (match(a:word, "Q") >= 0)
        return 'Qt'
    endif
    return a:docset
endfunction

function! OpenZealUnderCursor()
    let word = expand("<cword>")
    let docset = GetDocset()
    let docset = GetDocsetWord(docset, word)
    call RunZeal(docset, word)
endfunction

function! OpenZealWord(word)
    let docset = GetDocset()
    let docset = GetDocsetWord(docset)
    call RunZeal(docset, a:word)
endfunction

function! OpenZeal()
    if a:0 == 1
        call OpenZealWord(a:1)
    elseif a:0 == 2
        call RunZeal(a:1, a:2)
    else
        call OpenZealUnderCursor()
    endif
endfunction

nnoremap <leader>z :call OpenZeal()<cr>
