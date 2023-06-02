local focusmap = function(direction)
  vim.api.nvim_set_keymap('n', '<C><S>' .. direction, ":lua require'focus'.split_command('" .. direction .. "')<CR>",
    { silent = true })
end
-- Use `<Leader>h` to split the screen to the left, same as command FocusSplitLeft etc
focusmap('h')
focusmap('j')
focusmap('k')
focusmap('l')
