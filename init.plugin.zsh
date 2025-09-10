ME="${(%):-%x}"
CURRENT_DIR=$(dirname ${ME})

PLUGINS=(
    "antidote-plugin-manager"
    "fnm"
    "sdkman"
    "uv"
)

for PLUGIN in ${PLUGINS}; do
    source "${CURRENT_DIR}/${PLUGIN}/init.plugin.zsh"
done

source "${CURRENT_DIR}/theme.zsh"