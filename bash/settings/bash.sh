export HISTTIMEFORMAT='%F %H:%M  '
export HISTCONTROL=ignoredups
export HISTSIZE=5000
export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear"


export PROMPT_DIRTRIM=3

shopt -s nocaseglob
shopt -s autocd
shopt -s cmdhist
shopt -s dirspell
shopt -s dotglob
shopt -s histappend
#set -o noclobber  # prevent overwriting files with cat
#set -o ignoreeof  # stops ctrl+d from logging me out
shopt -s checkwinsize
# Don't wait for job termination notification
set -o notify

stty -ixon    # disable XON/XOFF flow control (^s/^q)

# Navigate history with up/down arrow
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# dircolors from trapd00r - https://github.com/trapd00r/LS_COLORS
eval $(dircolors -b $HOME/.dircolors)


# vi-Mode and little helpers
#set -o vi
# screen should be cleared on CTRL+L
#bind -m vi-insert "\C-l":clear-screen
#bind -m vi-insert "\C-e":edit-and-execute-command

# Really helpful on bash 4.3+/current readline:
# set show-mode-in-prompt on
# either in /etc/inputrc or ~/.inputrc

