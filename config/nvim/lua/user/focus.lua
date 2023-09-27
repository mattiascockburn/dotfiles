local focusmap = function(direction)
  vim.api.nvim_set_keymap('n', '<C><S>' .. direction, ":lua require'focus'.split_command('" .. direction .. "')<CR>",
    { silent = true })
end
-- Use `<Leader>h` to split the screen to the left, same as command FocusSplitLeft etc
focusmap('h')
focusmap('j')
focusmap('k')
focusmap('l')

local ignore_filetypes = { 'NvimTree_1' }
local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

local augroup =
    vim.api.nvim_create_augroup('FocusDisable', { clear = true })

vim.api.nvim_create_autocmd('WinEnter', {
  group = augroup,
  callback = function(_)
    if vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
    then
      vim.w.focus_disable = true
    else
      vim.w.focus_disable = false
    end
  end,
  desc = 'Disable focus autoresize for BufType',
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  callback = function(_)
    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
      vim.w.focus_disable = true
    else
      vim.w.focus_disable = false
    end
  end,
  desc = 'Disable focus autoresize for FileType',
})
