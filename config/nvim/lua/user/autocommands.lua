vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _mutt
    autocmd!
    autocmd BufRead,BufNewFile ~/.mutt/settings/* set ft=muttrc
  augroup end
  augroup _jenkins
    autocmd!
    au BufNewFile,BufRead *.groovy  setf groovy
    au BufNewFile,BufRead Jenkinsfile  setf groovy
  augroup end
    " Python stuff
  augroup _python
    autocmd!
    au BufNewFile,BufRead *.py set foldmethod=indent
  augroup end
  augroup _ansible
    autocmd!
    au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
    au BufRead,BufNewFile */ansible/*.yml set filetype=yaml.ansible
  augroup end
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal textwidth=72 spell
  augroup end
]]

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
