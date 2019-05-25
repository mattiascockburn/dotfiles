# make xdg-open use exo from the xfce project
export DE='xfce'
#WM=awesome
#WM=xfce4-session
WM=i3

# auto start screensaver
#xscreensaver &

# java bug (only grey windows with AWT apps)
wmname LG3D &

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#eval $(keychain --eval --agents ssh,gpg --quiet test_nopasswd)

# highdpi support
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export GDK_SCALE=1
# undo scaling of text:
# export GDK_DPI_SCALE=0.5

# auto mount devices
devmon --sync \
 --exec-on-drive "notify-send -u normal -t 2500 -a devmon -i xfce-mount 'Device mounted' '%f on %d'" \
 --exec-on-remove "notify-send -u normal -t 2500 -a devmon -i xfce-mount 'Device removed' '%f'" \
  &>~/.devmon.log &

#eyecandy or what?
# handled in i3config for now
#compton -bCGfF -o 0.38 -O 200 -I 200 -t 0 -l 0 -r 3 -D2 -m 0.88 &
#

autorandr -c &

# fucking beep
xset -b

# typical thinkpad setup
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Tapping Enabled' 1
# Gigabyte Aero 15
xinput set-prop 'ETPS/2 Elantech Touchpad' 'libinput Tapping Enabled' 1

# Automatically lock the session
exec xautolock -time 10 -detectsleep -bell 0 -locker 'slock' -notify 30 \
  -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in T-30'" &

#exec ck-launch-session dbus-launch
exec $WM $WMOPTS &> ~/.${WM}.log
