# Adapted from: https://www.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5ib9fs

export NVM_DIR="${HOME}/.local/share/nvm"

declare -a NODE_GLOBALS=(`find "${NVM_DIR}/versions/node" -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

NODE_GLOBALS+=("node")
NODE_GLOBALS+=("nvm")

function load_nvm () {
    echo "Loading NVM..."
    [[ -s "${NVM_DIR}/nvm.sh" ]] && . "${NVM_DIR}/nvm.sh"
}

for cmd in "${NODE_GLOBALS[@]}"; do
    read -r -d '' global_func <<HERE

function ${cmd}() {
    unset -f ${NODE_GLOBALS}
    load_nvm
    ${cmd} \$@
}

HERE

    eval "${global_func}"
done
