# customize settings if we are launched fromm nvim terminal
[[ -n "$NVIM_LISTEN_ADDRESS" ]] && {
  # vi mode is confusing inside vim
  set -o emacs
  # change vim/nvim to custom python script which launches a a file
  # inside the current session
  alias vim=nvim-edit
  alias nvim=nvim-edit

  # overwrite cd inside a nvim terminal in order to work the working directory inside nvim
  function cd() {
    builtin cd "$@";
    # if the parent process is nvim, do a vim cd
     nvim-send "lcd $@"
  }
  export cd
}
