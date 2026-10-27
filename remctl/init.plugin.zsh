REMCTL_COMPLETIONS_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/remctl/completions"
if [[ -d "${REMCTL_COMPLETIONS_DIR}" ]]; then
    echo "Loading remctl..."
    fpath+=( "${REMCTL_COMPLETIONS_DIR}" )
fi
