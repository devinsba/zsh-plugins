# Adapted from: https://www.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5ib9fs

export GVM_DIR="${HOME}/.local/opt/gvm"
if [[ -s "${GVM_DIR}/scripts/gvm" ]]; then
    echo "Loading gvm..."
    . "${GVM_DIR}/scripts/gvm"
fi
