# Adapted from: https://www.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5ib9fs

export RVM_DIR="${HOME}/.local/opt/rvm"
echo "Loading RVM..."
[[ -s "${RVM_DIR}/scripts/rvm" ]] && . "${RVM_DIR}/scripts/rvm"