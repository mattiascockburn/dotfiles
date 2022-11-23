local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("mason").setup()
local mlsp = require("mason-lspconfig")
local lspconfig = require("lspconfig")

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

-- require "user.lsp.null-ls"
