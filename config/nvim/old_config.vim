call plug#begin('~/.local/share/nvim/plugged')

" Easy commenting
Plug 'scrooloose/nerdcommenter'

" The less i type the more satisfied i am
Plug 'Raimondi/delimitMate'

" Initialize plugin system
call plug#end()

" Terminal behaviour
" Disable background color erase because of a bug in VIM which shows in kitty
" see https://github.com/kovidgoyal/kitty (search for bce)
let &t_ut=''

" ### Looks
syntax enable
set background=dark

" ### Auto Commands

" Remove trailing spaces on write
" https://stackoverflow.com/questions/6496778/vim-run-autocmd-on-all-filetypes-except
fun! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//e
endfun

autocmd FileType mail let b:noStripWhitespace=1
autocmd BufWritePre * call StripTrailingWhitespace()

" ## Folding
" disable floats in CoC floating windows
autocmd User CocOpenFloat :setl nofoldenable foldlevel=0 foldcolumn=0

" ### Completion
" ## Filename completion
set wildmenu
set wildmode=longest:full,full

" ignore unneccessary file types in autocomplete mode
set wildignore+=*.dict,*.aux,*.nav,*.out,*.toc,*.vrb,*.snm

" I don't want no fucking bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" ### Autoformat paragraphs
" First, disable bloody Q
nnoremap Q <NOP>
" Now, create a binding which auto formats the current paragraph
nnoremap Q :normal! gqip<cr>

" ### Buffers
" ALT-n next buffer and list, ALT-p previous buffer
nnoremap <A-n> :bnext<CR>:redraw<CR>:ls<CR>
nnoremap <A-p> :bprevious<CR>:redraw<CR>:ls<CR>
nnoremap <leader>vb :ls<cr>:vertical sb<space>

" Quickswitch to next/prev tab
nnoremap <A-.> :tabnext<cr>
nnoremap <A-,> :tabprevious<cr>

" ### Motion
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk


" ### Plugin Options
"
" Advanced ansible-vim config
let g:ansible_unindent_after_newline = 1
let g:ansible_extra_syntaxes = "sh.vim python.vim"
let g:ansible_attribute_highlight = "ob"
let g:ansible_extra_keywords_highlight = 1

let g:gutentags_generate_on_new = 1

let g:gutentags_cache_dir = '~/.tags'

" Buffer management
" fast buffer list/switch
nnoremap <leader><Space> :ls<cr>:b<space>

" Remap some stuff
" Swap v and CTRL-V, because Block mode is more useful
nnoremap v <C-V>
nnoremap <C-V> v
vnoremap v <C-V>
vnoremap <C-V> v

" Make CTRL+A work (jump to beginning) in commandline mode
cnoremap <C-A> <Home>

" No highlights
map <silent> <leader><cr> :noh<cr>

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Spawn terminals
map <leader>tt :spl term://zsh<cr>
map <leader>tv :vspl term://zsh<cr>
map <leader>T :tabe term://zsh<cr>

" Shortcut to switch to last used tab
let g:lasttab = 1
nmap <Leader>lt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Fancy listchars action, make tab and friends visible
" Also, add a toggle switch to the mix
" ripped off of https://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character
noremap <leader>lc :set list!<CR>
inoremap <leader>lc <C-o>:set list!<CR>
cnoremap <leader>lc <C-c>:set list!<CR>

" Shortcut for last used buffer
let g:lastusedbuffer = 1
au BufLeave * let g:lastusedbuffer = bufnr('%')
" Jump to last used buffer
map <leader>bl :execute "buffer" g:lastusedbuffer<cr>

map <leader>q :close<cr>

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

" Options for vim-workspace
nnoremap <leader>s :ToggleWorkspace<CR>
" Don't load on vim with args
let g:workspace_session_disable_on_args = 1

" Settings for fugitive
" Stolen from vimcasts.org
" Quickly go to parent tree in git object browsing mode
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

" Banish old fugitive read-only buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Some nifty mappings, courtesy of https://www.prodops.io/blog/solving-git-merge-conflicts-with-vim
" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" vim-magit, taken from
" https://jakobgm.com/posts/vim/git-integration/
" Open vimagit pane
" This is way better than fugitive 'git add -p' handling
nnoremap <leader>gs :Magit<CR>

" vimrc specific helpers
" stolen from https://superuser.com/questions/132029/how-do-you-reload-your-vimrc-file-without-restarting-vim
" automatically source vimrc after edit
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd
" Quickly edit/reload this configuration file
nnoremap <leader>gev :e $MYVIMRC<CR>

" Set some dicts for spell checking
setlocal dictionary=/usr/share/dict/german
setlocal dictionary+=/usr/share/dict/american-english

" go to normal mode even faster
nnoremap ; :

" Windows nvim-qt specific junk
if has("win32")
    " set a font that does not look like vomit
    set guifont=Inconsolata:h12:b
    " do not use GUI tablines, they are fucking with airline/ex
    set linespace=4
endif

" fix json comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

" Salt specific plugin options
let g:sls_use_jinja_syntax = 1

" Register hacks
" Do not pollute default register
noremap x "_x
vnoremap p "_dP

" Easy Align config
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

