local status_ok, cmp = pcall(require, "neogen")
if status_ok then
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
end
