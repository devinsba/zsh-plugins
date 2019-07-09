# Adapted from: https://www.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5ib9fs

export SDKMAN_DIR="${HOME}/.local/opt/sdkman"

if [[ -d "${SDKMAN_DIR}" ]]; then
    SDKMAN_GLOBALS=(`find "${SDKMAN_DIR}/candidates" -maxdepth 4 -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

    SDKMAN_GLOBALS+=("sdk")

    function load_sdkman () {
        echo "Loading SDKMAN..."
        [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && . "${SDKMAN_DIR}/bin/sdkman-init.sh"
    }

    for cmd in "${SDKMAN_GLOBALS[@]}"; do
        read -r -d '' global_func <<HERE

function ${cmd}() {
    unset -f ${SDKMAN_GLOBALS}
    load_sdkman
    ${cmd} \$@
}

HERE

        eval "${global_func}"
    done
fi
