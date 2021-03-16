" Bootstrap vim-plug if it's not there
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Version control commands for SVN, git and bzr
" This enables things like VCBlame
Plug 'juneedahamed/vc.vim'

" Visualize color definitions
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Add support for more text targets
Plug 'wellle/targets.vim'

" LSP code completion/diagnostics
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Tabline
" Show index and current status in tabline
Plug 'mkitt/tabline.vim'

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

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'

" Better buffer delete behaviour
" This plugin provides Bdelete and Bwipeout
Plug 'moll/vim-bbye'

" ctags Plugin, this one seems to be the simplest for
" noobs like myself
Plug 'ludovicchabant/vim-gutentags'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Async syntax linters/fixers
Plug 'dense-analysis/ale'

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
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'

" Visual helper
Plug 'Yggdroot/indentLine'

" Languages
Plug 'saltstack/salt-vim'
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.py' }
Plug 'vim-ruby/vim-ruby'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'tmux-plugins/vim-tmux'

" pandoc plugins
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" wiki stuff in vim
Plug 'vimwiki/vimwiki'

" themes
Plug 'lifepillar/vim-solarized8'

" git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'

" Saner match highlighting and search mappings
Plug 'wincent/loupe'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" syntax/indent/ftplugins for a many languages/tools
Plug 'sheerun/vim-polyglot'

" Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'mattiasgiese/neosnippet-snippets'
Plug 'honza/vim-snippets'
" Helper for context-specific snippets
Plug 'Shougo/context_filetype.vim'

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

" Markdown stuff
Plug 'plasticboy/vim-markdown'
Plug 'mzlogin/vim-markdown-toc'

" Use grep like a pro
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }

" Outline editor for many lightweight markup languages
Plug 'vim-voom/VOoM'

" Initialize plugin system
call plug#end()

" Terminal behaviour
" Disable background color erase because of a bug in VIM which shows in kitty
" see https://github.com/kovidgoyal/kitty (search for bce)
let &t_ut=''

" ### Looks
syntax enable
set background=dark
colorscheme solarized8_high

" ### Death to all rodents in textmode
set mouse=

" Show matching brackets when text indicator is over them
set showmatch

" set leader key to something more accessible
let mapleader = ","

" ### Spelling
set spelllang=de,en,es

" ### Auto Commands
autocmd BufRead,BufNewFile ~/.mutt/settings/* set ft=muttrc
autocmd FileType gitcommit setlocal textwidth=72 spell
au BufNewFile,BufRead *.groovy  setf groovy
au BufNewFile,BufRead Jenkinsfile  setf groovy
" Python stuff
au BufNewFile,BufRead *.py set foldmethod=indent

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

" ### Undo
set undolevels=1000
" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = $HOME . '/.local/vim/undo'
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

nnoremap <space> za

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2


" ### History
" Sets how many lines of history VIM has to remember
set history=1000


" ### Completion
" ## Filename completion
set wildmenu
set wildmode=longest:full,full

" ignore unneccessary file types in autocomplete mode
set wildignore+=*.dict,*.aux,*.nav,*.out,*.toc,*.vrb,*.snm

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
" Start scrolling 3 lines before edge of viewport
set scrolloff=3

" ### Split behaviour
if has('windows')
" Open horizontal splits below current window
  set splitbelow
endif

" Open vertical splits to the right of the current window
if has('vertsplit')
  set splitright
endif


" ### Format Options
" Delete comment leader on J
set formatoptions+=j
" Delete leading number on J (useful with numbered list)"
set formatoptions+=n

" ### Join behaviour
" Don't autoinsert two spaces after '.', '?', '!' for join command
set nojoinspaces

" ### Autoformat paragraphs
" First, disable bloody Q
nnoremap Q <NOP>
" Now, create a binding which auto formats the current paragraph
nnoremap Q :normal! gqip<cr>

" ### Buffers
" ALT-n next buffer and list, ALT-p previous buffer
nnoremap <A-n> :bnext<CR>:redraw<CR>:ls<CR>
nnoremap <A-p> :bprevious<CR>:redraw<CR>:ls<CR>

" Quickswitch to next/prev tab
nnoremap <A-.> :tabnext<cr>
nnoremap <A-,> :tabprevious<cr>

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

" ### Plugin Options
"
" Advanced ansible-vim config
let g:ansible_unindent_after_newline = 1
let g:ansible_extra_syntaxes = "sh.vim python.vim"
let g:ansible_attribute_highlight = "ob"
let g:ansible_extra_keywords_highlight = 1

" Markdown mode specific config
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'puppet']
let g:markdown_minlines = 100
let g:markdown_syntax_conceal = 0

let g:gutentags_generate_on_new = 1

let g:gutentags_cache_dir = '~/.tags'

" Customize airline prompt
" Unicode symbols, ripped from docs
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
let g:airline_theme='minimalist'


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
nnoremap <leader><Space> :b<space>

" Remap some stuff
" Swap v and CTRL-V, because Block mode is more useful
nnoremap v <C-V>
nnoremap <C-V> v
vnoremap v <C-V>
vnoremap <C-V> v

" Make CTRL+A work (jump to beginning) in commandline mode
cnoremap <C-A> <Home>

" Fast access to fzf
map <C-P> :FZF .<cr>
" FZF buffer list
map <leader>bb :Buffers<cr>

" Fast save
nmap <leader>w :w!<cr>

" No highlights
map <silent> <leader><cr> :noh<cr>

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Spawn terminals
map <leader>tt :spl term://zsh<cr>
map <leader>tv :vspl term://zsh<cr>
map <leader>T :tabe term://zsh<cr>

" Auomatically set the terminal title
set title

" Shortcut to switch to last used tab
let g:lasttab = 1
nmap <Leader>lt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Fancy listchars action, make tab and friends visible
" Also, add a toggle switch to the mix
" ripped off of https://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:␣
noremap <leader>lc :set list!<CR>
inoremap <leader>lc <C-o>:set list!<CR>
cnoremap <leader>lc <C-c>:set list!<CR>

" Shortcut for last used buffer
let g:lastusedbuffer = 1
au BufLeave * let g:lastusedbuffer = bufnr('%')
" Jump to last used buffer
map <leader>bl :execute "buffer" g:lastusedbuffer<cr>

map <leader>q :close<cr>

" some settings for ALE
" Error and warning signs.
let g:ale_sign_error = '💩'
let g:ale_sign_warning = '⚡'
let g:ale_completion_enabled = 0

" Python specific options for ale
let g:ale_python_auto_pipenv = 1
let g:ale_python_pylint_auto_pipenv = 1

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

" Options for vim-workspace
nnoremap <leader>s :ToggleWorkspace<CR>
" Don't load on vim with args
let g:workspace_session_disable_on_args = 1

" Neonippet configuration
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" No conceal markers
let g:neosnippet#enable_conceal_markers = 0

" Set a global directory for user defined snippets.
" These overwrite any snippets defined before.
" I use this to overwrite vimwiki snippets
let g:neosnippet#snippets_directory	= $HOME . '/.config/nvim/mysnippets'

" Keybindings
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" End of Neosnippet config

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
nnoremap <leader>gd :Gvdiff<CR>
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

" netrw settings
" Tweaks for browsing
" Only useful if we don't install NerdTree
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" go to normal mode even faster
nnoremap ; :

" Windows nvim-qt specific junk
if has("win32")
    " set a font that does not look like vomit
    set guifont=Inconsolata:h12:b
    " do not use GUI tablines, they are fucking with airline/ex
    set linespace=4
endif

" Config for vimwiki

" vimwiki with markdown support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Do not conceal anything by default
let g:vimwiki_conceallevel = 0

let wiki_default = {}
let wiki_default.path = '~/vimwiki/tech-notes'
let wiki_default.syntax = 'markdown'
let wiki_default.ext = 'md'
let wiki_default.nested_syntaxes = {'md':'markdown', 'sh':'sh','python': 'python', 'c++': 'cpp'}
let wiki_default.custom_wiki2html = '~/.local/bin/vimwiki_md_convert.py'
let wiki_default.template_default = 'GitHub'
let wiki_default.template_ext =  'html5'

let g:vimwiki_list = [wiki_default]

" fix json comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

" Salt specific plugin options
let g:sls_use_jinja_syntax = 1

" Register hacks
" Do not pollute default register
noremap x "_x
vnoremap p "_dP

" BEGIN COC specific settings

" Manage these extensions automatically
let g:coc_global_extensions = [ 'coc-powershell', 'coc-python', 'coc-json', 'coc-html', 'coc-highlight', 'coc-snippets', 'coc-vimlsp', 'coc-texlab', 'coc-yaml', 'coc-xml', 'coc-git', 'coc-marketplace', 'coc-emoji', 'coc-dictionary', 'coc-tag', 'coc-neosnippet', 'coc-yank', 'coc-sh']

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" END COC specific settings

" BEGIN COC plugin settings

" coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" coc-yank
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

" END COC plugin settings

" BEGIN vim-grepper settings
nnoremap <leader>G :Grepper -tool git<cr>
nnoremap <leader>g :Grepper -tool rg<cr>
nnoremap <leader>gw :Grepper -tool rg -cword -noprompt<cr>

" Configure operators. These may be used with motions
" e.g.: gsiW gsi) etc.
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
" END vim-grepper settings


" 'smart' rename
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)

" Displaying documentation (in the floating window!)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Do not hide characters in, for example, markdown mode
set conceallevel=0

