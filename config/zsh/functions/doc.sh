doc-build() {
  IMAGE=localhost/suse-latex
  DOCKER_OPTS=''
  if [ -n "$TEXMF" ]; then
    DOCKER_OPTS="${DOCKER_OPTS} -v${TEXMF}:/home/build/texmf:ro"
  fi
  CMD="cd ~/svn; make $@"
  # puppet docs "automagic"
  if [ -x ./inputdoc ]; then
    [[ -z "$1" ]] && CMD='cd ~/svn/; ./inputdoc'
  fi
  if [ "$1" = 'shell' ]; then
    CMD='/bin/bash'
  elif [ "$1" = 'single' ]; then
    if [ -z "$2" ]; then
      echo You need to supply a filename
      exit 1
    fi
    CMD="cd ~/svn; pdflatex $2"
  elif [ "$1" = 'command' ]; then
    if [ -z "$2" ]; then
      echo You need to supply a command
      exit 1
    fi
    CMD="cd ~/svn; $2"
  fi
  podman run -t -i --net=none --userns keep-id --rm $DOCKER_OPTS -v $(pwd):/home/build/svn:z $IMAGE bash -c "$CMD"
}

watchbuild() {
  [[ $# -lt 1 ]] && {
    echo Fail
    return
  }
  fn="$1"
  echo "$1" | entr zsh -ic "doc-build \"$1\""
}
alias wb=watchbuild

# set/get doc:status

docstat() {
  [[ "$#" -lt 1 ]] && {
    exit Fail
    return
  }
  mod=$1
  shift
  case "$mod" in
    get)
      svn propget doc:status $@
      ;;
    set)
      prop=$1
      shift
      svn propset doc:status $prop $@
  esac
}
