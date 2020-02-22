func! vice#lightline#filename()
    if &ft == 'startify' | return '' | endif
    let fname = expand('%')

    return fname == 'ControlP'                ? g:lightline.ctrlp_item :
         \ fname == '__Tagbar__'              ? g:lightline.fname :
         \ fname =~ '__Gundo\|NERD_tree'      ? '' :
         \ &ft   == 'vimfiler'                ? vimfiler#get_status_string() :
         \ &ft   == 'unite'                   ? unite#get_status_string() :
         \ &ft   == 'vimshell'                ? vimshell#get_status_string() :
         \ (''   != vice#lightline#readonly() ? vice#lightline#readonly().' ' : '') .
         \ (''   != fname                     ? fname : '[No Name]') .
         \ (''   != vice#lightline#modified() ? ' '.vice#lightline#modified() : '')
endf

func! vice#lightline#fileformat()
    if &ft == 'startify' | return '' | endif
    return winwidth(0) > 70 ? &fileformat : ''
endf

func! vice#lightline#fileencoding()
    if &ft == 'startify' | return '' | endif
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endf

func! vice#lightline#filetype()
    if &ft == 'startify' | return '' | endif
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endf

func! vice#lightline#mode()
    if &ft == 'startify' | return '' | endif
    let fname = expand('%:t')

    return fname == '__Tagbar__'        ? 'Tagbar' :
         \ fname == 'ControlP'          ? 'CtrlP' :
         \ fname == '__Gundo__'         ? 'Gundo' :
         \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
         \ fname =~ 'NERD_tree'         ? 'NERDTree' :
         \ &ft   == 'unite'             ? 'Unite' :
         \ &ft   == 'vimfiler'          ? 'VimFiler' :
         \ &ft   == 'vimshell'          ? 'VimShell' :
         \ winwidth(0) > 60 ? lightline#mode() : ''
endf

func! vice#lightline#modified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : ''
endf

func! vice#lightline#readonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endf

func! vice#lightline#ctrlp_mark()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item, g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endf

func! vice#lightline#ctrlp_status_main(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_item  = a:item
    let g:lightline.ctrlp_next  = a:next
    let g:lightline.ctrlp_prev  = a:prev
    let g:lightline.ctrlp_regex = a:regex
    return lightline#statusline(0)
endf

func! vice#lightline#ctrlp_status_prog(str)
    return lightline#statusline(0)
endf

func! vice#lightline#fugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = '± '
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry
    return ''
endf

func! vice#lightline#tagbar_status(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endf

func! vice#lightline#neomake()
    if !exists('*neomake#statusline#LoclistCounts')
        return ''
    endif

    " Count all the errors, warnings
    let total = 0

    for v in values(neomake#statusline#LoclistCounts())
        let total += v
    endfor

    for v in items(neomake#statusline#QflistCounts())
        let total += v
    endfor

    if total == 0
        return ''
    endif

    return 'line '.getloclist(0)[0].lnum. ', 1 of '.total
endf
