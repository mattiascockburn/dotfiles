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
