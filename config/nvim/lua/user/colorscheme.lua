vim.cmd [[
try
  colorscheme solarized8_high
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
