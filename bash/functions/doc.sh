watchbuild() {
  [[ $# -lt 1 ]] && {
    echo Fail
    return
  }
  fn="$1"
  export -f doc-build
  echo "$1" | entr bash -c "doc-build \"$1\""
}
