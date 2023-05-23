function MasonLspPackages()
  local registry = require("mason-registry")
  local lsp = {}
  for _, pkg_info in ipairs(registry.get_installed_packages()) do
    for _, type in ipairs(pkg_info.spec.categories) do
      if type == "LSP" then
        table.insert(lsp, pkg_info.name)
      end
    end
  end
  return lsp
end

local lspconfig = require("lspconfig")
local servers = MasonLspPackages()

for _, server in pairs(servers) do
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
