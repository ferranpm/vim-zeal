if has('win32') || has('win64')
    let s:zeal_pre = "start"
    let s:zeal_post = ""
else
    let s:zeal_pre = ""
    let s:zeal_post = " &"
endif

let s:filetype_zeal = {
            \ 'c': 'c',
            \ 'h': 'c',
            \ 'cpp': 'c++',
            \ 'css': 'css',
            \ 'html': 'html',
            \ 'java': 'java',
            \ 'js': 'javascript',
            \ 'markdown': 'markdown',
            \ 'md': 'markdown',
            \ 'mdown': 'markdown',
            \ 'mkd': 'markdown',
            \ 'mkdn': 'markdown',
            \ 'php': 'php',
            \ 'py': 'python',
            \ 'scss': 'sass',
            \ 'sh': 'bash',
            \ 'tex': 'latex',
            \ }

function! zeal#GetDocset()
    if has_key(s:filetype_zeal, &filetype) == 1
        let docset = s:filetype_zeal[&filetype]
    else
        let docset = &filetype
    endif
    return docset
endfunction

" Gets the docset by the current docset and the word
" e.g.: Qt and c++ (all keywords start with 'Q')
function! zeal#GetDocsetWord(docset, word)
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

function! zeal#RunZeal(docset, word)
    execute ":silent !".s:zeal_pre." ".g:zeal_exec." --query ".a:docset.":".a:word.s:zeal_post
    redraw!
endfunction

function! zeal#RunZealUnderCursor()
    let word = expand("<cword>")
    call zeal#RunZealWord(word)
endfunction

function! zeal#RunZealWord(word)
    let docset = zeal#GetDocset()
    let docset = zeal#GetDocsetWord(docset, a:word)
    call zeal#RunZeal(docset, a:word)
endfunction
