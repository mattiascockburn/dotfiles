#!/bin/bash
DEST=/mnt/amarula/data/usenet/watch
FILE="$@"
echo moving $FILE to $DEST
echo "$FILE" | grep -qE '.nzb$' || exit 0
mv "$FILE" "$DEST" && notify-send "Moved file $FILE to usenet watch dir"
