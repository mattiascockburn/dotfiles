#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

eval $(keychain --timeout 60 --eval --quiet ~/.ssh/test_nopasswd)

# Disable overlay scrollbars, be it GTK3 or liboverlay
export LIBOVERLAY_SCROLLBAR=0
export GTK_OVERLAY_SCROLLING=0

# add local bin to PATH
[[ ! "$PATH" =~ "${HOME/\//\//}\/.local/bin" ]] && export PATH="${HOME}/.local/bin:${PATH}"
[[ ! "$PATH" =~ "${HOME/\//\//}\/.gem/ruby/2.4.0/bin" ]] && export PATH="${HOME}/.gem/ruby/2.4.0/bin:${PATH}"

# source all settings
for category in aliases settings functions ; do
  for setting in $HOME/.bash/$category/*.sh;do
    . $setting
  done
done

### OTHER FILES
for stuff in ~/{.profile,.alias,.bash_secrets}; do
  [[ -f $stuff ]] && . $stuff
done

### PROMPT
#Magic Monty GitPrompt for Bash, really handy
export GIT_PROMPT_THEME='Default_NoExitState'
export GIT_PROMPT_END='\n(\j) >> '
. ~/.bash/bash-git-prompt/gitprompt.sh

# MISC
# no cowsay in ansible
export ANSIBLE_NOCOWS=1


# Automatically start X on TTY1
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx 
fi

