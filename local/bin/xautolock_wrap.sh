#!/bin/bash
# simple wrapper for xautolock
set -u

if [ $# -lt 1 ];then
   echo fooo
   exit 1
fi

mode="$1"

case $mode in 
   enable|disable)
      ;;
   *)
      echo wrong mode
      exit 1
esac

xautolock "-${mode}"
if [ $? -eq 0 ];then
   notify-send -t 2 -u low "automatic lock set to $mode"
else
   notify-send -t 2 -u critical "failed to set automatic lock to $mode"
fi

