[[ -f ~/.login_env ]] && . ~/.login_env

# Start keychain on login
eval $(keychain --eval --quiet ~/.ssh/test_nopasswd)

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Automatically start X or sway on TTY1
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  if $(which sway &>/dev/null) && [[ -n "$USE_SWAY" ]] ; then
    # make sure toolkits are forced to use wayland
        export _JAVA_AWT_WM_NONREPARENTING=1
    export AWT_TOOLKIT=MToolkit

    # TEMPORARY disable enforcement of Wayland support in apps
    # According to https://github.com/swaywm/sway/wiki/Running-programs-natively-under-wayland
    # GDK_BACKEND should not be set
    #export GDK_BACKEND=wayland # unset for electron apps
    #export QT_QPA_PLATFORM=wayland
    #export QT_QPA_PLATFORMTHEME=qt5ct
    #export CLUTTER_BACKEND=wayland
    #export SDL_VIDEODRIVER=wayland

    #export XDG_SESSION_TYPE=wayland
    #export XDG_SESSION_DESKTOP=sway
    #export XDG_CURRENT_DESKTOP=sway
    # Make Java apps look less shitty
    export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

    pkd=/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
    [ -x "$pkd" ] && exec "$pkd" &
    exec sway &> ~/.sway.log &
  else
    # Make Java apps look less shitty
    export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
    exec startx
  fi
fi
