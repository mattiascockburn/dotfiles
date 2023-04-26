# Source all functions so that they are always available,
# even in non-interactive shells
for f in ~/.config/zsh/functions/*.sh;do
  source $f
done

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi


which direnv &>/dev/null && {
  _direnv_hook() {
    trap -- '' SIGINT;
    eval "$("/usr/bin/direnv" export zsh)";
    trap - SIGINT;
  }
  typeset -ag precmd_functions;
  if [[ -z "${precmd_functions[(r)_direnv_hook]+1}" ]]; then
    precmd_functions=( _direnv_hook ${precmd_functions[@]} )
  fi
  typeset -ag chpwd_functions;
  if [[ -z "${chpwd_functions[(r)_direnv_hook]+1}" ]]; then
    chpwd_functions=( _direnv_hook ${chpwd_functions[@]} )
  fi
}

[[ -f ~/.alias ]] && source ~/.alias

