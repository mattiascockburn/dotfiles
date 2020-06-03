#
# ~/.bash_profile
#

[[ -f ~/.login_env ]] && . ~/.login_env

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [[ -z "$SSH_AUTH_SOCK" ]]; then
  eval $(keychain --eval --quiet ~/.ssh/test_nopasswd)
fi

if [ -n "$AUTOSTART_GUI" ]; then
  # Automatically start X or sway on TTY1
  if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    if command -v sway &>/dev/null && [[ -n "$USE_SWAY" ]] ; then
      # make sure toolkits are forced to use wayland
      export GDK_BACKEND=wayland
      export CLUTTER_BACKEND=wayland
      export QT_QPA_PLATFORM=wayland-egl
      export ECORE_EVAS_ENGINE=wayland_egl
      export ELM_ENGINE=wayland_egl
      export SDL_VIDEODRIVER=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1
      exec sway
    else
      exec startx
      true
    fi
  fi
fi
