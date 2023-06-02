" Terminal behaviour
" Disable background color erase because of a bug in VIM which shows in kitty
" see https://github.com/kovidgoyal/kitty (search for bce)
" let &t_ut=''

" I don't want no fucking bell
" set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Windows nvim-qt specific junk
if has("win32")
    " set a font that does not look like vomit
    set guifont=Inconsolata:h12:b
    " do not use GUI tablines, they are fucking with airline/ex
    set linespace=4
endif

" Easy Align config
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

