" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Better mark management
Plug 'kshenoy/vim-signature'

" Multi cursor, whoop whoop
Plug 'terryma/vim-multiple-cursors'

"Open file under cursor with 'gf'
Plug 'amix/open_file_under_cursor.vim'

" Make sure you use single quotes
"
" fuzzy file completion, me gusta!
Plug 'ctrlpvim/ctrlp.vim'

" ctags Plugin, this one seems to be the simplest for
" noobs like myself
Plug 'ludovicchabant/vim-gutentags'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Async File Linter, whoohoo
Plug 'w0rp/ale'

" Easily align text
" used by puppet-vim
Plug 'godlygeek/tabular'

" ctags support/puppet-vim
Plug 'majutsushi/tagbar'

" reqs for snipmate (utility plugins)
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'

Plug 'garbas/vim-snipmate'

Plug 'rodjek/vim-puppet'

" Highlight ugly extra whitespace
Plug 'ntpeters/vim-better-whitespace'

" tpope FTW
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-markdown'


" Languages
Plug 'saltstack/salt-vim'
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.py' }
Plug 'python-mode/python-mode', {'branch': 'develop'}

" Tabmanager - visualizing tabs in vim
Plug 'kien/tabman.vim'

" themes
Plug 'josuegaleas/jay'
Plug 'chriskempson/base16-vim'
Plug 'tomasr/molokai'
Plug 'flazz/vim-colorschemes'
Plug 'endel/vim-github-colorscheme'
Plug 'owickstrom/vim-colors-paramount'
Plug 'atelierbram/Base2Tone-vim'

" git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" search files with ack/ag
Plug 'mileszs/ack.vim'


Plug 'vim-airline/vim-airline'

" syntax/indent/ftplugins for a many languages/tools
Plug 'sheerun/vim-polyglot'

" Powershell syntax
Plug 'PProvost/vim-ps1'

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" The less i type the more satisfied i am
Plug 'Raimondi/delimitMate'

" TOML syntax is handy for some hipster tech
Plug 'cespare/vim-toml'

"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }


" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()

" Terminal behaviour
" Disable background color erase because of a bug in VIM which shows in kitty
" see https://github.com/kovidgoyal/kitty (search for bce)
let &t_ut=''

" ### Looks
syntax enable
set background=dark
" colorscheme jay
colorscheme molokai

" ### Death to all rodents in textmode
set mouse=

" Show matching brackets when text indicator is over them
set showmatch

" set leader key to something more accessible
let mapleader = ","

" ### Auto Commands
autocmd BufRead,BufNewFile ~/git/layer8/ansible-stuff/*.yml/ syntax=ansible
autocmd FileType gitcommit setlocal textwidth=72 spell
au BufNewFile,BufRead *.groovy  setf groovy
au BufNewFile,BufRead Jenkinsfile  setf groovy
" ### Undo
set undolevels=100

" ### Behaviour
" I hate tabs.
set expandtab           " enter spaces when tab is pressed
set textwidth=100       " break lines when line length increases
set tabstop=2           " use 2 spaces to represent tab
set softtabstop=2
set shiftwidth=2        " number of spaces to use for auto indent
set softtabstop=2

set iskeyword+=_,$,@,%,#    " none of these are word dividers

" ## Filetypes
filetype plugin on
filetype indent on

" ## Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

 " Allow backspacing over indent, eol, and the start of an insert
set backspace=2


" ### History
" Sets how many lines of history VIM has to remember
set history=700


" ### Completion
" ## Filename completion
set wildmenu
set wildmode=longest:full,full

" With ack-vim: Use the_silver_searcher if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


"" ignore unneccessary file types in autocomplete mode
set wildignore+=*.dict,*.aux,*.nav,*.out,*.toc,*.vrb,*.snm
"
" I don't want no fucking bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


" ### Search
set incsearch
set ignorecase

" Set the search scan to wrap around the file
set wrapscan
" Turn on Highlighting of search results
set hlsearch

" ### Buffers
" ALT-n next buffer and list, ALT-p previous buffer
nnoremap <A-n> :bnext<CR>:redraw<CR>:ls<CR>
nnoremap <A-p> :bprevious<CR>:redraw<CR>:ls<CR>
nnoremap <C-n> :bnext<CR>:redraw<CR>
nnoremap <C-p> :bprevious<CR>:redraw<CR>

" ### Motion
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" ### Movement
" https://neovim.io/doc/user/nvim_terminal_emulator.html
" Use `ALT+{h,j,k,l}` to navigate windows from any mode:
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" ### Encoding
" Make sure utf-8 is used
" Not really needed for neovim but vim
set encoding=utf-8
set termencoding=utf-8

" ### Nifty tricks
" Write files as root
command W w !sudo tee % > /dev/null

" ### Plugin Options
"
" CtrlP.vim should be used for Ctrl+p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Working Path Mode:
" 'c' - the directory of the current file.
" 'a' - the directory of the current file, unless it is a subdirectory of the cwd
" 'r' - the nearest ancestor of the current file that contains one of these directories or files: .git .hg .svn .bzr _darcs
" 'w' - modifier to "r": start search from the cwd instead of the current file's directory
" 0 or '' (empty string) - disable this feature.
let g:ctrlp_working_path_mode = 'ra'

" Tabman
" Default hotkeys
let g:tabman_toggle = '<leader>mt'
let g:tabman_focus  = '<leader>mf'
let g:tabman_side = 'left'
let g:tabman_width = 25
" Set this to 1 to show windows created by plugins, help and quickfix:
let g:tabman_specials = 0
" Set this to 0 to disable line numbering in the TabMan window:
let g:tabman_number = 1

" Advanced ansible-vim config
let g:ansible_unindent_after_newline = 1
let g:ansible_extra_syntaxes = "sh.vim python.vim"
let g:ansible_attribute_highlight = "ob"
let g:ansible_extra_keywords_highlight = 1

" tpope-markdown mode specific config
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'puppet']
let g:markdown_minlines = 100

" pymode
let g:pymode_python = 'python3'

let g:gutentags_generate_on_new = 1
" Force gutentags to ignore certain roots as projects
let g:gutentags_exclude_project_root = ['/home/mattias','/home/giesmat']

" Define some general purpose shortcuts
" NERDTree
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr><Paste>

" Fast save
nmap <leader>w :w!<cr>

" No highlights
map <silent> <leader><cr> :noh<cr>

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

