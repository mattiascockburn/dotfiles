#!/bin/bash
PIA_BASE=~/.pia

[[ $# -lt 1 ]] && {
  echo Must supply config file name without .ovpn Suffix
}

c="$1"
cd $PIA_BASE

if [[ "$1" = 'list' ]]; then
  ls *.ovpn | sed -e 's/\.ovpn//g'
else
  sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
  sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
  sudo openvpn --config "${c}.ovpn"
fi
