" Bootstrap vim-plug if it's not there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" deoplete plugins
" Python goodness
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'Shougo/neco-syntax'
" vim syntax
Plug 'Shougo/neco-vim', { 'for': 'vim' }

" deoplete source for Dockerfile
Plug 'deoplete-plugins/deoplete-docker', { 'for': 'Dockerfile' }

" emoji junk
Plug 'fszymanski/deoplete-emoji'

" deoplete support for go
Plug 'deoplete-plugins/deoplete-go', { 'for': 'go' }
Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/vim/plugged/gocode/nvim/symlink.sh' }

" Mutt/e-mail stuff
Plug 'nicoe/deoplete-khard'

" Spell checking
Plug 'deathlyfrantic/deoplete-spell'

" End of deoplete plugins


" Session management
Plug 'thaerkh/vim-workspace'

" Scalpel: better word replacer within a file
" invoked with <Leader>e by default
Plug 'wincent/scalpel'

" Briefly highlight the yanked region
Plug 'machakann/vim-highlightedyank'

" Macro helper
" <CR> will replay last recorded macro
Plug 'wincent/replay'

" Better mark management
Plug 'kshenoy/vim-signature'

"Open file under cursor with 'gf'
Plug 'amix/open_file_under_cursor.vim'

" Make sure you use single quotes
"
Plug 'junegunn/fzf.vim'

" Better buffer delete behaviour
" This plugin provides Bdelete and Bwipeout
Plug 'moll/vim-bbye'

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

Plug 'rodjek/vim-puppet'

" Highlight ugly extra whitespace
Plug 'ntpeters/vim-better-whitespace'

" tpope FTW
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-eunuch'

" Visual helper
Plug 'Yggdroot/indentLine'

" Languages
Plug 'saltstack/salt-vim'
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.py' }
Plug 'python-mode/python-mode', {'branch': 'develop'}
Plug 'vim-ruby/vim-ruby'
Plug 'Glench/Vim-Jinja2-Syntax'

" pandoc plugins
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" wiki stuff in vim
Plug 'vimwiki/vimwiki'

" PyDoc to quickly access documentation
Plug 'fs111/pydoc.vim'

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
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'

" git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Powerful multi file search
Plug 'wincent/ferret'

" Saner match highlighting and search mappings
Plug 'wincent/loupe'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" syntax/indent/ftplugins for a many languages/tools
Plug 'sheerun/vim-polyglot'

" Powershell syntax
Plug 'PProvost/vim-ps1'

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Snippets

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree'

" Use NERDtree with ack
Plug 'tyok/nerdtree-ack'

" Easy commenting
Plug 'scrooloose/nerdcommenter'

" The less i type the more satisfied i am
Plug 'Raimondi/delimitMate'

" TOML syntax is handy for some hipster tech
Plug 'cespare/vim-toml'

" Go support
Plug 'fatih/vim-go'

" terraform syntax
Plug 'hashivim/vim-terraform'

" postgresql syntax
Plug 'lifepillar/pgsql.vim'

"
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }


" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

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
" colorscheme molokai
colorscheme solarized8_high

" ### Death to all rodents in textmode
set mouse=

" Show matching brackets when text indicator is over them
set showmatch

" set leader key to something more accessible
let mapleader = ","

" ### Spelling
set spelllang=en

" ### Auto Commands
autocmd BufRead,BufNewFile ~/git/layer8/ansible-stuff/*.yml/ syntax=ansible
autocmd BufRead,BufNewFile ~/.mutt/settings/* set ft=muttrc
autocmd FileType gitcommit setlocal textwidth=72 spell
au BufNewFile,BufRead *.groovy  setf groovy
au BufNewFile,BufRead Jenkinsfile  setf groovy

" Remove trailing spaces on write
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * %s/\s\+$//e

" ### Undo
set undolevels=1000
" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = '~/.local/vim/undo'
    " Create dirs
    call system('mkdir -p' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" ### Behaviour
" I hate tabs.
set expandtab           " enter spaces when tab is pressed
set textwidth=100       " break lines when line length increases
set tabstop=2           " use 2 spaces to represent tab
set softtabstop=2
set shiftwidth=2        " number of spaces to use for auto indent
set softtabstop=2

set iskeyword+=_,$,@,%,#    " none of these are word dividers

" automativcally save when building through e.g. make
set autowrite

" ## Filetypes
filetype plugin on
filetype indent on

" ## Folding
set foldmethod=syntax
set foldlevelstart=1
set foldnestmax=10
set foldenable
set foldlevel=1

 " Allow backspacing over indent, eol, and the start of an insert
set backspace=2


" ### History
" Sets how many lines of history VIM has to remember
set history=700


" ### Completion
" ## Filename completion
set wildmenu
set wildmode=longest:full,full

"" ignore unneccessary file types in autocomplete mode
set wildignore+=*.dict,*.aux,*.nav,*.out,*.toc,*.vrb,*.snm
"
" I don't want no fucking bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


" ### Search
set incsearch
set smartcase

" Set the search scan to wrap around the file
set wrapscan
" Turn on Highlighting of search results
set hlsearch

" Do not bother me when there are unsaved changes on buffer switch
set hidden

" ### Scroll behaviour
set scrolloff=3                       " start scrolling 3 lines before edge of viewport

" ### Split behaviour
if has('windows')
  set splitbelow                      " open horizontal splits below current window
endif

if has('vertsplit')
  set splitright                      " open vertical splits to the right of the current window
endif


" ### Format Options
set formatoptions+=j " delete comment leader on J
set formatoptions+=n " delete leading number on J (useful with numbered list)"

" ### Join behaviour
set nojoinspaces                      " don't autoinsert two spaces after '.', '?', '!' for join command

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

if has('nvim')
  " Make it easier to get out of terminal mode
  tnoremap <Esc> <C-\><C-n>
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
  " Enable pasting in terminal insert mode trhough ALT+r + Register
  tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

  " Make window switching more pleasant
  tnoremap <A-h> <C-\><C-N><C-w>h
  tnoremap <A-j> <C-\><C-N><C-w>j
  tnoremap <A-k> <C-\><C-N><C-w>k
  tnoremap <A-l> <C-\><C-N><C-w>l
endif
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
vnoremap <A-h> <C-\><C-N><C-w>h
vnoremap <A-j> <C-\><C-N><C-w>j
vnoremap <A-k> <C-\><C-N><C-w>k
vnoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" If we have nvr available
if has('nvim')
  if executable('nvr')
    " make sure that programs which use
    " $VISUAL open in the current instance
    let $VISUAL = 'nvr -cc split --remote-wait'
  endif
endif

" ### Visual mode
if has('virtualedit')
  set virtualedit=block               " allow cursor to move where there is no text in visual block mode
endif

" ### Encoding
" Make sure utf-8 is used
" Not really needed for neovim but vim
set encoding=utf-8
set termencoding=utf-8

" ### Nifty tricks
" Write files as root
command! W w !sudo tee % > /dev/null

" ### Plugin Options
"
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
let g:markdown_syntax_conceal = 0

" pymode
let g:pymode_python = 'python3'

let g:gutentags_generate_on_new = 1
" Force gutentags to ignore certain roots as projects
let g:gutentags_cache_dir = '~/.tags'

" Customize airline prompt
" unicode symbols, ripped from docs
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.notexists   = '∄'
let g:airline_symbols.whitespace   = 'Ξ'

let g:airline_theme='dark'

" Looks
" Make vertical bar more pleasing to the eye
if has('folding')
  set fillchars=vert:│
endif

" Live preview of substitutions
if has('nvim')
  set inccommand=split
endif

" show numbers
set number
set relativenumber

" Buffer management
" fast buffer list/switch
nnoremap <Space> :ls<cr>:b

" Remap some stuff
" Swap v and CTRL-V, because Block mode is more useful
nnoremap v <C-V>
nnoremap <C-V> v
vnoremap v <C-V>
vnoremap <C-V> v

" Define some general purpose shortcuts
" NERDTree
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr><Paste>

" fast access to fzf
map <leader>F :FZF!<cr>
map <leader>f :FZF
map <C-P> :FZF .<cr>

" Fast save
nmap <leader>w :w!<cr>

" No highlights
map <silent> <leader><cr> :noh<cr>

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Spawn terminals
map <leader>tt :spl term://bash<cr>
map <leader>tv :vspl term://bash<cr>
map <leader>T :tabe term://bash<cr>
" Enter insert mode when we switch to a terminal
" Super useful 😻
:au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" Auomatically set the terminal title
set title

" Shortcut to switch to last used tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Shortcut for last used buffer
let g:lastusedbuffer = 1
au BufLeave * let g:lastusedbuffer = bufnr('%')
" jump to last used buffer
map <leader>bl :execute "buffer" g:lastusedbuffer<cr>

map <leader>q :close<cr>

" fzf buffer list
map <leader>B :Buffers<cr>

" some settings for ale
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

" Make jumping between errors in quickfix list easier
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" suggestion from vim-go tutorial, rebind some commands
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

" more higlight options for vim-go
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" options for vim-workspace
nnoremap <leader>s :ToggleWorkspace<CR>
" don't load on vim with args
let g:workspace_session_disable_on_args = 1

" neonippet configuration
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" keybindings
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" settings for ferret
nmap <leader>z <Plug>(FerretAckWord)
nmap <leader>x <Plug>(FerretAck)

" settings for fugitive
" stolen from vimcasts.org
" quickly go to parent tree in git object browsing mode
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

" banish old fugitive read-only buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

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
nnoremap gev :e $MYVIMRC<CR>

" some deoplete settings
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
let g:deoplete#enable_at_startup = 1

" do not conceal syntax by default
set conceallevel=0
