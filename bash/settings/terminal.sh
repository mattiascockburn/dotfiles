# Is bash run in terminology?
# If yes, enable sexy ls and stuff ;)
if [ -n "$TERMINOLOGY" ];then

  alias ls='tyls'

fi

### FIXES

# fix color limitation in xfce4-terminal
if [ -e /usr/share/terminfo/x/xterm-256color ] && [ "$COLORTERM" == "xfce4-terminal" ]; then
  export TERM=xterm-256color
fi

# Change the window title of X terminals

# Fix terminal settings when using rxvt

[[ x$TERM = xrxvt-unicode-256color ]] && export TERM=xterm
case $TERM in
        xterm*|rxvt*|Eterm|Terminal*|term*)
                PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
                ;;
        screen)
                PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
                ;;
esac

# deactivate HIDPI scaling for alacritty
# see https://github.com/jwilm/alacritty/issues/1501
export WINIT_HIDPI_FACTOR=1.0
