#!/bin.bash
DISK=/dev/disk/by-partuuid/5f5ea1b8-7844-4269-8a25-4e104df26817
NAME=cryptjunk
MNT=/mnt/toshiba

[[ $# -lt 1 ]] && exit 1

case "$1" in
  open)
    sudo cryptsetup luksOpen "$DISK" "$NAME"
    sudo mount "/dev/mapper/${NAME}" "$MNT"
    ;;
  close)
    sudo umount "$MNT"
    sudo cryptsetup luksClose "/dev/mapper/${NAME}"
    ;;
  *)
    echo wtf?
    exit 1
esac

