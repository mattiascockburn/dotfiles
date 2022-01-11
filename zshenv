# Source all functions so that they are always available,
# even in non-interactive shells
for f in ~/.config/zsh/functions/*.sh;do
  source $f
done

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

[[ -f ~/.alias ]] && source ~/.alias

