function! complete#MyComplete()
    if pumvisible()
        return g:forward_complete ? "\<C-n>" : "\<C-p>"
    else
        if s:WillComplete()
            let g:forward_complete = 0
            return "\<C-p>"
        else
            return "\<TAB>"
        endif
    endif
endfunction

function! s:WillComplete()
    let line = getline('.')
    let cnum = col('.') - 1
    let post = line[cnum - 1:]

    for pattern in ['$', '\s', '[(){}\[\]]']
        if post =~ '^' . pattern
            return 0
        endif
    endfor

    return 1
endfunction

function! complete#WrapOmni()
    let g:forward_complete = 1
    return "\<C-X>\<C-O>"
endfunction
