local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use("wbthomason/packer.nvim") -- Have packer manage itself
  use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  use("numToStr/Comment.nvim") -- Easily comment stuff
  use("kyazdani42/nvim-web-devicons")
  use("kyazdani42/nvim-tree.lua")

  -- Better buffer delete behaviour
  -- This plugin provides Bdelete and Bwipeout
  use("moll/vim-bbye")
  use("nvim-lualine/lualine.nvim") -- enhanced status line plugin
  use("lewis6991/impatient.nvim") -- cache lua plugins and reduce load times significantly
  use("lukas-reineke/indent-blankline.nvim") -- visualize indentation of lines
  use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight

  -- Easily align text
  -- used by puppet-vim
  use("godlygeek/tabular")
  use("rodjek/vim-puppet") -- puppet syntax support and formatting helpers

  -- Highlight ugly extra whitespace
  use("ntpeters/vim-better-whitespace")

  -- tpope FTW
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use("tpope/vim-endwise")
  use("tpope/vim-speeddating")
  use("tpope/vim-eunuch")
  -- use 'tpope/vim-unimpaired'

  -- Languages
  -- syntax/indent/ftplugins for a many languages/tools
  use("saltstack/salt-vim")
  use("hashivim/vim-terraform")
  use("lifepillar/pgsql.vim")

  -- git helpers
  use("tpope/vim-fugitive")
  use("jreybert/vimagit")
  use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })

  -- Open file under cursor with 'gf'
  use("amix/open_file_under_cursor.vim")

  -- ctags helper, this one seems to be the simplest for
  -- noobs like myself
  use("ludovicchabant/vim-gutentags")

  -- Easily align text according to a chosen seperator
  use("junegunn/vim-easy-align")

  -- Saner match highlighting and search mappings
  use("wincent/loupe")

  -- Colorschemes
  -- use 'lunarvim/colorschemes' -- A bunch of colorschemes you can try out
  use("lunarvim/darkplus.nvim")
  use("lifepillar/vim-solarized8")
  use("EdenEast/nightfox.nvim")

  -- cmp plugins
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("hrsh7th/cmp-nvim-lsp")
  use("saadparwaiz1/cmp_luasnip") -- snippet completions

  -- snippets
  use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" }) -- nice snippet engine, latest major release
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
  use("honza/vim-snippets") -- even more snippets

  -- LSP
  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  })
  use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  use("b0o/schemastore.nvim") -- use schemastore.org for json schemas in jsonls
  use("folke/trouble.nvim") -- Nice overview of errors/warnings coming from e.g. LSP
  use("folke/lsp-colors.nvim") -- add LSP colors for colorschemes that don't yet support them
  use("ap/vim-css-color")

  -- DAP / Debug Adapter Protocol related plugins
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  -- Higlight current breakpoint/point in debugging
  use { 'theHamsta/nvim-dap-virtual-text', requires = { "mfussenegger/nvim-dap" } }
  use 'leoluz/nvim-dap-go' -- requires delve
  use 'mfussenegger/nvim-dap-python' -- requires debugpy https://github.com/microsoft/debugpy

  -- Telescope / fast file search/grep
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-dap.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("nvim-treesitter/nvim-treesitter-context")

  -- Add support for more text targets
  use("wellle/targets.vim")

  -- Scalpel: better word replacer within a file
  -- invoked with <Leader>e by default
  use("wincent/scalpel")

  -- Git
  use("lewis6991/gitsigns.nvim")
  use("rhysd/git-messenger.vim")

  -- Movement
  use("ggandor/leap.nvim")

  if is_bootstrap then
    require('packer').sync()
  end

end)
