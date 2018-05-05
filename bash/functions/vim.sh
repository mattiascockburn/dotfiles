# Determine how to start vi/vim/nvim
vim() {
  # neovim goodness present? if so, use it
  if which nvim &>/dev/null; then
    vimcmd=nvim
  fi

  # If neovim-remote is installed we use it by default
  if which nvr &>/dev/null; then
    vimcmd=nvr
  fi
  cmdsuffix=''
  # If i run in a terminal spawned by nvim
  # i want to close the terminal when i execute
  # vim, because i don't want a unused terminal
  # buffer hanging around
  if [[ -n $NVIM_LISTEN_ADDRES ]]; then
    cmdsuffix='; exit'
  fi
  $vimcmd $@ $cmdsuffix
}

