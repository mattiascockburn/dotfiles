" some fugitive settings,
" mostly ripped from vimcasts.org

" clean up fugitive buffers automatically
autocmd BufReadPost fugitive://* set bufhidden=delete

" In a tree/blobview opened by Gedit, this mapping
" will go to the parent tree-object with '..'
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

