#!/bin/bash

bt_activate() {
bluetooth on # neccessary?
rfkill unblock bluetooth
bluetoothctl << EOF
power on
discoverable off
agent on
default-agent
EOF
}

bt_deactivate() {
rfkill block bluetooth
bluetooth off
}

bt_connected() {
  device=$1
  if [[ -z "$device" ]]; then
    echo Do not fuck with me and give me a device string to check for
  fi
  bluetoothctl <<< 'devices' | sed -e 's/\x1B\[[0-9;]*[JKmsu]//g' | grep -q "^\[$device\].*" && break
}

boombox() {
bt_activate
bluetoothctl << EOF
connect C9:50:76:F5:EF:06
EOF
# There is no obvious way to block while waiting for the connection
# so this is a nasty busy loop. Hardcoding FTW
while true; do
  # Thank god we have stockoverflow. And fuck this fucking piece of shit bluetoothctl
  # https://unix.stackexchange.com/questions/55546/removing-color-codes-from-output`
  bt_connected 'Anker A3143' && break
  sleep 2
done
# set defautl sink. this is ugly but oh well
pacmd set-default-sink bluez_sink.C9_50_76_F5_EF_06.a2dp_sink
}
