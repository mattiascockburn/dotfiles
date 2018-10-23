#web browser
#export BROWSER=qutebrowser

# mosh settings
export MOSH_TITLE_NOPREFIX=1

#pager/editor
export PAGER=most
export EDITOR=vim
which nvim &>/dev/null && export EDITOR=nvim
export VISUAL=$EDITOR

#grep
export GREP_COLOR='1;32'
