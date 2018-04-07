# I am usually running kitty as a temrinal emulator.
# Because most remote systems don't have the right terminfo
# i need to activate it before-hand in order to reduce pain
# and anger

ssh-terminfo() {
  set -u
  terminfo="$1"
  server="$2"
  set +u
  echo Activating terminfo for $terminfo on $server
  ssh $server "mkdir -p \~/.terminfo"
  infocmp "$terminfo" | ssh "$server" "cat > /tmp/custom.terminfo"
  ssh "$server" tic -x -o \~/.terminfo /tmp/custom.terminfo
}

