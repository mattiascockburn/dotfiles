#!/bin/bash

xset s off -dpms
while true; do
  LD_PRELOAD=/usr/\$LIB/libgamemodeauto.so.0 emulationstation.sh &>/tmp/emulationstation.log
  zenity --question --text 'Restart emulationstation?' --no-wrap --default-cancel --icon-name face-surprise
  rc=$?
  if [[ "$rc" -eq 0 ]]; then
    notify-send -u low -t 5000 'Restarting in 5 seconds'
    sleep 5
  else
    exit
  fi
done
