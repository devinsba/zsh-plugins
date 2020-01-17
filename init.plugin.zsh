ME="${(%):-%x}"
CURRENT_DIR=$(dirname ${ME})

PLUGINS=(
    "antibody-plugin-manager"
    "nvm"
    "rvm"
    "sdkman"
)

for PLUGIN in ${PLUGINS}; do
    source "${CURRENT_DIR}/${PLUGIN}/init.plugin.zsh"
done
