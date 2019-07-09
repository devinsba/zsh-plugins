# Adapted from: https://www.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5ib9fs

export RVM_DIR="${HOME}/.local/opt/rvm"

RUBY_GLOBALS=(`find "${RVM_DIR}/rubies" -maxdepth 3 -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

RUBY_GLOBALS+=("rvm")

function load_rvm () {
    echo "Loading RVM..."
    [[ -s "${RVM_DIR}/scripts/rvm" ]] && . "${RVM_DIR}/scripts/rvm"
}

for cmd in "${RUBY_GLOBALS[@]}"; do
    read -r -d '' global_func <<HERE

function ${cmd}() {
    unset -f ${RUBY_GLOBALS}
    load_rvm
    ${cmd} \$@
}

HERE

    eval "${global_func}"
done
