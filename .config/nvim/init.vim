" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

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

Plug 'pearofducks/ansible-vim'

Plug 'vim-syntastic/syntastic'

" themes
Plug 'josuegaleas/jay'
Plug 'chriskempson/base16-vim'
Plug 'tomasr/molokai'

" git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" search files with ack/ag
Plug 'mileszs/ack.vim'


Plug 'vim-airline/vim-airline'

" syntax/indent/ftplugins for a many languages/tools
Plug 'sheerun/vim-polyglot'


" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
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

" Use the_silver_searcher if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

syntax enable
set background=dark
colorscheme jay
