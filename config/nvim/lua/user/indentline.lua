local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
  return
end

vim.g.indentLine_enabled = 0

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

ibl.setup({
  indent = {
    char = '┊',
  },
  exclude = {
    buftypes = {
      "terminal",
      "nofile",
      "mail"
    },
    filetypes = {
      "help",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
    },
  },
})
