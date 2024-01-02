HISTFILE=~/.cache/zshistory
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob notify
unsetopt beep

zstyle :compinstall filename '/home/mattias/.config/zshrc'

autoload -Uz compinit
compinit

# Enable colors and change prompt:
autoload -U colors && colors

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

if which starship &>/dev/null; then
  source ~/.config/zsh/prompt.conf
fi

# enable reverse history search
bindkey '^r' history-incremental-search-backward

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Enable emacs keybindings that i am missing from vi-mode
bindkey -v '^E' end-of-line
bindkey -a '^E' end-of-line
bindkey -v '^A' beginning-of-line
bindkey -a '^A' beginning-of-line
bindkey -v '^W' backward-delete-word
bindkey -a '^W' backward-delete-word

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl+x ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Use bash config dir for now for cross-shell aliases
for a in ~/.bash/aliases/*.sh; do
  source $a
done

# HACK HACK HACK :'-(
source ~/.bash/functions/misc.sh

# History search functionality
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# source all other config snippets
for a in ~/.config/zsh/{*.conf,functions/*.sh}; do
    source $a
done

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

choose_bin() {
  [[ $# -lt 2 ]] && return
  var="$1"
  bin="$2"
  which $bin &>/dev/null && eval "export $var=$bin"
}

for ed in vim nvim; do
  choose_bin EDITOR $ed
done
which most &>/dev/null && export PAGER=most

# most chokes on some escape sequences of delta
export DELTA_PAGER='less -R'

export PATH="${HOME}/.local/bin:${PATH}"

# Add custom LSPs/DAPs installed by mason
mason_path=~/.local/share/nvim/mason/bin/
[[ -d "$mason_path" ]] && export PATH="${PATH}:${mason_path}"

# Add go binaries to PATH
go_path=~/go/bin
[[ -d "$go_path" ]] && export PATH="${PATH}:${go_path}"

# Krew is a plugin manager for kubectl
krew_path="${HOME}/.krew/bin"
[[ -d $krew_path ]] && export PATH="${PATH}:${krew_path}"

for prog in flux kind; do
  which $prog &>/dev/null && . <($prog completion zsh)
done

# Use zsh fzf plugin
[[ -d "${HOME}/.zsh/fzf-zsh-plugin/bin" ]] && {
  export PATH="${PATH}:${HOME}/.zsh/fzf-zsh-plugin/bin"
  source "${HOME}/.zsh/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh"
}

# package 'z', switch to the most "frecent" directory with a given name: https://github.com/rupa/z/
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

[[ -f ~/.cache/wal/sequences ]] && cat ~/.cache/wal/sequences
# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
