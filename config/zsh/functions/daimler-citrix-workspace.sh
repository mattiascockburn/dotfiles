# Source this file in your shell (bash/zsh) and use the function to spawn your browser
daimler-citrix-workspace() {
  IMAGE=localhost/daimler-citrix-workspace:latest
  shift
  XSOCK=/tmp/.X11-unix
  XAUTH=$(mktemp /tmp/.docker.xauth-XXXXX)
  xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
  podman run -i -t \
    --rm \
    -v /var/run/dbus:/var/run/dbus \
    -v /var/run/user/$(id -u):/var/run/user/root \
    -e TERM \
    -e DBUS_SESSION_BUS_ADDRESS \
    -v /etc/localtime:/etc/localtime:ro \
    -v /etc/machine-id:/etc/machine-id \
    -v $XSOCK:$XSOCK \
    -v $XAUTH:$XAUTH \
    -e DISPLAY=unix$DISPLAY \
    -e XAUTHORITY=$XAUTH \
    -e GDK_SCALE \
    -e GDK_DPI_SCALE \
    --device /dev/snd \
    --device /dev/dri \
    --userns keep-id \
    $IMAGE "$@"

  rm "$XAUTH"
}
