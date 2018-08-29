"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim ftdetect file
" Language: TSX (Typescript)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Whether the .jsx extension is required.
if !exists('g:tsx_ext_required')
  let g:tsx_ext_required = 1
endif

" Whether the @tsx pragma is required.
if !exists('g:tsx_pragma_required')
  let g:tsx_pragma_required = 0
endif

if g:tsx_pragma_required
  " Look for the @tsx pragma.  It must be included in a docblock comment before
  " anything else in the file (except whitespace).
  let s:tsx_pragma_pattern = '\%^\_s*\/\*\*\%(\_.\%(\*\/\)\@!\)*@tsx\_.\{-}\*\/'
  let b:tsx_pragma_found = search(s:tsx_pragma_pattern, 'npw')
endif

" Whether to set the TSX filetype on *.js files.
fu! <SID>EnableTSX()
  if g:tsx_pragma_required && !b:tsx_pragma_found | return 0 | endif
  if g:tsx_ext_required && !exists('b:tsx_ext_found') | return 0 | endif
  return 1
endfu

autocmd BufNewFile,BufRead *.tsx let b:tsx_ext_found = 1
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.ts
  \ if <SID>EnableTSX() | set filetype=typescript.tsx | endif
