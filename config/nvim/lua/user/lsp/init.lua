local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
local neodev, _ = pcall(require, "neodev")
if neodev then
  require("neodev").setup({
    -- add any options here, or leave empty to use the default settings
  })
end

require("mason").setup()
local mlsp = require("mason-lspconfig")
local lspconfig = require("lspconfig")

require('mason-tool-installer').setup {
  ensure_installed = {
    { 'bash-language-server', auto_update = true },
    'lua-language-server',
    'vim-language-server',
  },
  auto_update = false,
  run_on_start = true,
  start_delay = 3000, -- 3 second delay
  debounce_hours = 5, -- at least 5 hours between attempts to install/update
}

mlsp.setup()

for _, server in pairs(mlsp.get_installed_servers()) do
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  lspconfig[server].setup(opts)
end
