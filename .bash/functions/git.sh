#!/bin/bash

git-nuke() {

[[ "$#" -lt 1 ]] && {
  echo You need to supply a filename to git-nuke
  return 1
}

cat <<EOF
Completely _NUKE_ $1 from the current git repo?
Press CTRL+C to cancel
EOF
read foo

git filter-branch --index-filter "git rm --cached $1" HEAD

}

git-push-hooks() {
# stolen from https://stackoverflow.com/questions/1797074/local-executing-hook-after-a-git-push
# and somehow customized
GIT_DIR_="$(git rev-parse --git-dir)"
BRANCH="$(git rev-parse --symbolic --abbrev-ref $(git symbolic-ref HEAD))"

PRE_PUSH="$GIT_DIR_/hooks/pre-push"
POST_PUSH="$GIT_DIR_/hooks/post-push"

test -x "$PRE_PUSH" && "$PRE_PUSH" "$BRANCH" "$@"

git push "$@"

test $? -eq 0 && test -x "$POST_PUSH" && "$POST_PUSH" "$BRANCH" "$@" 
}
