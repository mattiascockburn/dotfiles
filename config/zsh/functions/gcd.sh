# go to a path relative to the top directory
# of the current git worktree.
# from: https://dmerej.info/blog/post/fzf-for-the-win/
function gcd() {
    topdir=$(git rev-parse --show-toplevel)
    if [[ $? -ne 0 ]]; then
        return 1
    fi
    cd "${topdir}/${1}"
}
