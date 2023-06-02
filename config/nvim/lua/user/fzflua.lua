local status_ok, fzf = pcall(require, "fzf-lua")
if not status_ok then
  return
end

local map = vim.keymap.set
local opts = {
  silent = true,
  noremap = true
}
map("n", "<Leader>sf", function() fzf.files() end, opts)
map("n", "<Leader>sg", function() fzf.live_grep_native() end, opts)
map("n", "<Leader>st", function() fzf.tags() end, opts)
map("n", "<Leader><Space>", function() fzf.buffers() end, opts)
