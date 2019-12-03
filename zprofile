[[ -f ~/.login_env ]] && . ~/.login_env

# Start keychain on login
eval $(keychain --eval --quiet ~/.ssh/test_nopasswd)
