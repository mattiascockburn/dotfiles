doc-build() {
  IMAGE=localhost/suse-latex
  BASEDIR=/build/svn
  DOCKER_OPTS=''
  if [ -n "$TEXMF" ]; then
    DOCKER_OPTS="${DOCKER_OPTS} -v${TEXMF}:/${BASEDIR}/texmf:ro"
  fi
  CMD="cd ${BASEDIR}; make $*"
  # puppet docs "automagic"
  if [ -x ./inputdoc ]; then
    [[ -z "$1" ]] && CMD="cd ${BASEDIR}; ./inputdoc"
  fi
  if [ "$1" = 'shell' ]; then
    CMD='/bin/bash'
  elif [ "$1" = 'single' ]; then
    if [ -z "$2" ]; then
      echo You need to supply a filename
      exit 1
    fi
    CMD="cd ${BASEDIR}; pdflatex $2"
  elif [ "$1" = 'command' ]; then
    if [ -z "$2" ]; then
      echo You need to supply a command
      exit 1
    fi
    CMD="cd ${BASEDIR}; $2"
  fi
  podman run -t -i --net=none --userns keep-id --rm $DOCKER_OPTS -v "$(pwd):${BASEDIR}:z" "$IMAGE" bash -c "$CMD"
}

