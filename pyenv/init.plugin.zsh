# Adapted from: https://www.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5ib9fs

export PYENV_ROOT="${HOME}/.local/opt/pyenv"

if [[ -d "${PYENV_ROOT}" ]]; then
    echo "Importing pyenv..."
    export PATH="${PYENV_DIR}/bin:${PATH}"

    PYTHON_GLOBALS=(`ls "${PYENV_ROOT}/shims/" | xargs -n1 basename | sort | uniq`)

    PYTHON_GLOBALS+=("pyenv")

    function load_pyenv () {
        echo "Loading pyenv..."
        if command -v pyenv; then
            eval "$(pyenv init - zsh)"
        fi
    }

    for cmd in "${PYTHON_GLOBALS[@]}"; do
        read -r -d '' global_func <<HERE

function ${cmd}() {
    unset -f ${PYTHON_GLOBALS}
    load_pyenv
    ${cmd} \$@
}

HERE

        eval "${global_func}"
    done
fi
