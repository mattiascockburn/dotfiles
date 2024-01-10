local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  "nvim-lua/popup.nvim",   -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  "numToStr/Comment.nvim", -- Easily comment stuff
  -- Better buffer delete behaviour
  -- This plugin provides Bdelete and Bwipeout
  "moll/vim-bbye",
  "nvim-lualine/lualine.nvim",           -- enhanced status line plugin
  "lewis6991/impatient.nvim",            -- cache lua plugins and reduce load times significantly
  "lukas-reineke/indent-blankline.nvim", -- visualize indentation of lines
  -- Easily align text
  -- used by puppet-vim
  "godlygeek/tabular",
  "rodjek/vim-puppet", -- puppet syntax support and formatting helpers
  -- Highlight ugly extra whitespace
  "ntpeters/vim-better-whitespace",
  -- tpope FTW
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "tpope/vim-endwise",
  "tpope/vim-speeddating",
  "tpope/vim-eunuch",
  -- Languages
  -- syntax/indent/ftplugins for a many languages/tools
  "saltstack/salt-vim",
  "hashivim/vim-terraform",
  "lifepillar/pgsql.vim",
  "neomutt/neomutt.vim",
  "towolf/vim-helm",
  -- git helpers
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua",       -- optional
    },
    config = true
  },
  -- Open file under cursor with 'gf'
  "amix/open_file_under_cursor.vim",
  -- ctags helper, this one seems to be the simplest for
  -- noobs like myself
  "ludovicchabant/vim-gutentags",
  -- Easily align text according to a chosen seperator
  "junegunn/vim-easy-align",
  -- Saner match highlighting and search mappings
  "wincent/loupe",
  -- Colorschemes
  -- 'lunarvim/colorschemes' -- A bunch of colorschemes you can try out
  "EdenEast/nightfox.nvim",
  -- cmp plugins
  "hrsh7th/nvim-cmp",          -- The completion plugin
  "hrsh7th/cmp-buffer",        -- buffer completions
  "FelipeLema/cmp-async-path", -- async path completions
  "hrsh7th/cmp-cmdline",       -- cmdline completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  -- File Management Helpers
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },
  -- nifty filesystem editing
  {
    'stevearc/oil.nvim',
    config = function() require('oil').setup() end
  },
  -- YAML helper
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" }, -- optional
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- snippets
  "L3MON4D3/LuaSnip",             -- nice snippet engine, latest major release
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use
  "honza/vim-snippets",           -- even more snippets
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    }
  },

  -- Markdown preview
  { 'toppair/peek.nvim',     run = 'deno task --quiet build:fast' },
  { "ellisonleao/glow.nvim", config = function() require("glow").setup() end },

  -- Markdown helper
  -- key mappings are defined in `ftplugin/markdown.lua`
  "allen-mack/nvim-table-md",

  -- LSP
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
  },
  "folke/neodev.nvim",               -- helper for neovim lua dev
  "tamago324/nlsp-settings.nvim",    -- language server settings defined in json for
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  "b0o/schemastore.nvim",            -- schemastore.org for json schemas in jsonls
  {
    "folke/trouble.nvim",            -- Nice overview of errors/warnings coming from e.g. LSP
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  "folke/lsp-colors.nvim",         -- add LSP colors for colorschemes that don't yet support them
  "ap/vim-css-color",
  "lukas-reineke/lsp-format.nvim", -- autoformat using Language servers on write
  "RRethy/vim-illuminate",         -- illuminate current keyword in buffer
  -- DAP / Debug Adapter Protocol related plugins
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    }
  },
  -- Higlight current breakpoint/point in debugging
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = {
      "mfussenegger/nvim-dap"
    },
  },
  'leoluz/nvim-dap-go',           -- requires delve
  'mfussenegger/nvim-dap-python', -- requires debugpy https://github.com/microsoft/debugpy
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  },
  "nvim-treesitter/nvim-treesitter-context",
  { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  },

  "wellle/targets.vim", -- Add support for more text targets
  -- Scalpel: better word replacer within a file
  -- invoked with <Leader>e by default
  "wincent/scalpel",
  -- Git
  "lewis6991/gitsigns.nvim",
  "rhysd/git-messenger.vim",
  "direnv/direnv.vim",         -- direnv integration
  "AndrewRadev/splitjoin.vim", -- change between one line and multiline statements with gJ and gS
  -- decode/encode base64 directly in vim
  { 'taybart/b64.nvim' },
  "akinsho/toggleterm.nvim",
  {
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup(
        {
          excluded_filetypes = { "toggleterm" },
          excluded_buftypes = { "help" }
        }
      )
    end
  },
  -- automatically create annotations for a multitude of languages
  {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
}

local opts = {}

require("lazy").setup(plugins, opts)
