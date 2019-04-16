#!/bin/bash
# read a youpoop url from the x11 clipboard and download it using youtube-dl
# quickly cobbled together by a lazy bastard (Mattias Giese)
set -euo pipefail

export AUDIO_SAVEDIR="${HOME}/audio/youpoop"
export VIDEO_SAVEDIR="${HOME}/Videos/youtube"

[[ $# -lt 1 ]] && {
  echo Fail: must give either music or video as argument
  exit 1
}

mode="$1"
case $mode in
  music)
    YT_OPTS='--audio-quality 0 --audio-format mp3 --extract-audio'
    SAVEDIR=$AUDIO_SAVEDIR
    ;;
  video)
    YT_OPTS=''
    SAVEDIR=$VIDEO_SAVEDIR
    ;;
  *)
    echo Fail. invalid mode $mode. music or video
    exit 1
esac

n() {
  case $1 in
     error)
        opt='-u critical'
        ;;
     *)
        opt='-u low'
  esac

  shift

  notify-send $opt -a youpoop -t 3000 "$*"
}

url="$(xclip -o)"
mkdir -p "$SAVEDIR" && cd "$SAVEDIR"
n info "Starting youpoop download for $url"
title=$(youtube-dl --get-title $url)
n info "Downloading $title"
youtube-dl -t $YT_OPTS --no-progress -o "%(title)s-%(id)s.%(ext)s" --restrict-filenames "$url"
[[ $? -ne 0 ]] && {
  n error "Download of $title failed"
  exit 1
}
n info "Download of $title successful"
