#!/bin/bash
# pia.sh - ghetto wrapper around openvpn for privateinteraccess.com
# Needs Linux, sudo, bash, openvpn, openbsd-netcat and wget
PIA_BASE=~/.pia
MGMTSOCKET=~/.pia_mgmt

[[ $# -lt 1 ]] && {
  echo Must supply config file name without .ovpn Suffix
}
mkdir -p "$PIA_BASE"
cd "$PIA_BASE"

PASS=''
USER=''
PASS_NAME=privateinternetaccess.com
PFILE="$(mktemp ~/.pia_auth.XXX)"
PID=~/.pia_pid

UPDATE_URL='https://www.privateinternetaccess.com/openvpn/openvpn-ip.zip'

get_pass() {
  PASS=$(pass show $PASS_NAME | head -1)
  USER=$(pass show $PASS_NAME | awk 'NR==3 { print $2 }')
  cat <<EOF >"$PFILE"
$USER
$PASS
EOF

}

connect() {
  [[ -z "$1" ]] && usage
  if [[ -r "$PID" ]];then
    pgrep -F "$PID" && {
      echo Still running as $p
      exit
    }
  fi
  sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
  sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
  sudo openvpn --config "${1}.ovpn" --management "$MGMTSOCKET" unix --auth-user-pass "$PFILE" --writepid "$PID" &
  sleep 1 # because sleep is always good 😸
  mypid=$(cat $PID)
  echo OpenVPN running as PID $mypid
  rm "$PFILE"
}

update() {
  mkdir -p old
  t=$(mktemp /tmp/pia_vpn_config.XXX)
  echo Downloading pia configs from $UPDATE_URL
  wget -q -O "$t" "$UPDATE_URL"
  [[ $? -ne 0 ]] && {
    echo Download of pia configs failed
    exit 1
  }
  mv ./* old
  unzip "$t"
  rm "$t"
  echo Download of pia configs complete
}

list() {
  ls *.ovpn | sed -e 's/\.ovpn//g'
}

get_status() {
  pgrep -F "$PID"
  if [[ "$?" -eq 0 ]]; then
    echo OpenVPN is running
    nc -NU "$MGMTSOCKET" <<<"status"
  else
    echo OpenVPN is NOT running
    exit 1
  fi
}

get_pid() {
  nc -NU "$MGMTSOCKET" <<<'pid'
}

get_bytecount() {
  interval=15
  [[ -n "$1" ]] && interval="$1"
  nc -U "$MGMTSOCKET" <<<"bytecount $interval"
}


usage() {
cat <<-EOF
$0 list|update|connect
list: list openvpn configs
update: download new configs from
connect [config]: connect with specified config
EOF
exit
}

trap cleanup INT

cleanup() {
  echo CTRL+C pressed, cleaning up
  rm -f "$PFILE" "$PID" "$MGMTSOCKET"
}

case "$1" in
  list)
    list ;;
  update)
    update ;;
  connect)
    get_pass
    connect "$2" ;;
  status)
    get_status ;;
  pid)
    get_pid ;;
  bytes)
    get_bytecount "$2" ;;
  *)
    usage ;;
esac
