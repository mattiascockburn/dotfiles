# Source all functions so that they are always available,
# even in non-interactive shells
for f in ~/.config/zsh/functions/*.sh;do
  source $f
done

[[ -f ~/.alias ]] && source ~/.alias
