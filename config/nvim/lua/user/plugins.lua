local fn = vim.fn

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  -- Better buffer delete behaviour
  -- This plugin provides Bdelete and Bwipeout
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

  -- Easily align text
  -- used by puppet-vim
  use 'godlygeek/tabular'
  use 'rodjek/vim-puppet'

  -- Highlight ugly extra whitespace
  use 'ntpeters/vim-better-whitespace'

  -- tpope FTW
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-endwise'
  use 'tpope/vim-speeddating'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-unimpaired'

  -- Languages
  -- syntax/indent/ftplugins for a many languages/tools
  use 'sheerun/vim-polyglot'
  use 'saltstack/salt-vim'
  use 'vim-ruby/vim-ruby'
  use 'Glench/Vim-Jinja2-Syntax'
  use 'tmux-plugins/vim-tmux'
  use 'hashivim/vim-terraform'
  use 'lifepillar/pgsql.vim'
  use 'plasticboy/vim-markdown'

  -- wiki stuff in vim
  use 'vimwiki/vimwiki'

  -- git helpers
  use 'tpope/vim-fugitive'
  use 'jreybert/vimagit'
  -- Open file under cursor with 'gf'
  use 'amix/open_file_under_cursor.vim'

  -- ctags helper, this one seems to be the simplest for
  -- noobs like myself
  use 'ludovicchabant/vim-gutentags'

  -- Easily align text according to a chosen seperator
  use 'junegunn/vim-easy-align'

  -- Saner match highlighting and search mappings
  use 'wincent/loupe'

  -- Colorschemes
  -- use 'lunarvim/colorschemes' -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  use 'lifepillar/vim-solarized8'

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Add support for more text targets
  use 'wellle/targets.vim'

  -- Scalpel: better word replacer within a file
  -- invoked with <Leader>e by default
  use 'wincent/scalpel'

  -- Git
  use "lewis6991/gitsigns.nvim"
end)
