vim.g.loaded_clipboard_provider = 0
vim.g.clipboard = {
  name = "void",
  copy = {
    ["+"] = true,
    ["*"] = true
  },
  paste = {
    ["+"] = {},
    ["*"] = {}
  }
}

require 'user.options'
require 'user.keymaps'
require 'user.plugins'
require 'user.autocommands'
require 'user.lualine'
require 'user.lsp'
require 'user.dap'
require 'user.treesitter'
require 'user.colorscheme'
require 'user.cmp'
require 'user.chatgpt'
require 'user.gitsigns'
require 'user.indentline'
require 'user.comment'
require 'user.impatient'
require 'user.telescope'
require 'user.comment'
require 'user.autopairs'
require 'user.nvim-tree'
require 'user.trouble'

vim.cmd 'source ~/.config/nvim/old_config.vim'
