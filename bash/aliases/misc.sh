which nvim &>/dev/null && alias vim='nvim'
alias tb="(exec 3<>/dev/tcp/termbin.com/9999; cat >&3; cat <&3; exec 3<&-)"
