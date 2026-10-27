# Adapted from: https://www.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5ib9fs

export RVM_DIR="${HOME}/.local/opt/rvm"
if [[ -s "${RVM_DIR}/scripts/rvm" ]]; then
    echo "Loading RVM..."
    . "${RVM_DIR}/scripts/rvm"
fi