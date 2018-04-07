#!/bin/bash
declare -a terminal=( kitty urxvt xterm )

for terminal in ${terminal[@]}; do
  if which "$terminal" &>/dev/null; then
    $terminal $@ &
    exit
  fi
done
