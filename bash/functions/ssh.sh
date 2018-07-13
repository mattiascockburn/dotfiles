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
_completion_loader ssh
complete -F _ssh s

# Really ugly workaround, but transferring terminfo to every system
# is not feasible and i don't need fancy features on remotes
s() {
  case "$TERM" in
    xterm-kitty)
      export OLD_TERM=$TERM
      export TERM=xterm
      ;;
    *)
      true
      ;;
  esac
  'ssh' $@
  export TERM=$OLD_TERM
}
