function! woohoo#invert_signs_toggle()
  if g:woohoo_invert_signs == 0
    let g:woohoo_invert_signs=1
  else
    let g:woohoo_invert_signs=0
  endif

  colorscheme woohoo
endfunction

" Search Highlighting {{{

function! woohoo#hls_show()
  set hlsearch
  call WoohooHlsShowCursor()
endfunction

function! woohoo#hls_hide()
  set nohlsearch
  call WoohooHlsHideCursor()
endfunction

function! woohoo#hls_toggle()
  if &hlsearch
    call woohoo#hls_hide()
  else
    call woohoo#hls_show()
  endif
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
