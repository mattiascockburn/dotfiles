#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='>> '

eval $(keychain --eval --quiet ~/.ssh/test_nopasswd)

# Disable overlay scrollbars, be it GTK3 or liboverlay
export LIBOVERLAY_SCROLLBAR=0
export GTK_OVERLAY_SCROLLING=0

# add local bin to PATH
[[ ! "$PATH" =~ "${HOME/\//\//}\/.local/bin" ]] && export PATH="${HOME}/.local/bin:${PATH}"
[[ ! "$PATH" =~ "${HOME/\//\//}\/rvm\/gems/ruby/2.4.1/bin" ]] && export PATH="${HOME}/.rvm/gems/ruby/2.4.1/bin:${PATH}"

# add .luarocks bin to PATH if it exists
[[ -d "$HOME/.luarocks/bin" ]] && {
  [[ ! "$PATH" =~ "${HOME/\//\//}\/.lluarocks/bin" ]] && export PATH="${HOME}/.luarocks/bin:${PATH}"
}

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
# Magic Monty GitPrompt for Bash, really handy
# https://github.com/magicmonty/bash-git-prompt
GIT_PROMPT_THEME='Default_NoExitState'
#GIT_PROMPT_THEME='Crunch'

# set some special colors for the prompt end
GREEN="\[$(tput setaf 2)\]"
LIGHT_BLUE="\[$(tput setaf 39)\]"
RESET="\[$(tput sgr0)\]"
GIT_PROMPT_END="\n${GREEN}[${LIGHT_BLUE}\h${GREEN}]${RESET}\$ "
[[ -f ~/.bash/bash-git-prompt/gitprompt.sh ]] && . ~/.bash/bash-git-prompt/gitprompt.sh

# MISC
# no cowsay in ansible
export ANSIBLE_NOCOWS=1


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
r=$(type -t rvm)
[[ "$r" = 'function' ]] && export PATH="$PATH:$HOME/.rvm/bin"

# use rvm bash completion if present
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

# add private bin if it exists
[[ -d ~/.private/bin ]] && export PATH="~/.private/bin:${PATH}"

# Show error code if run command was not successful
#EC() { echo -e '\e[1;33m'code $?'\e[m\n'; }
EC() {
  RC=$?
  if [ $RC != '148' ]; then
    cowsay -d "failed: $RC" | toilet -f term --gay
  fi
}
trap EC ERR

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
