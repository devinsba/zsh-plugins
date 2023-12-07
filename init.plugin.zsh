ME="${(%):-%x}"
CURRENT_DIR=$(dirname ${ME})

PLUGINS=(
    "antibody-plugin-manager"
    "gvm"
    "nvm"
    "pyenv"
    "rvm"
    "sdkman"
)

for PLUGIN in ${PLUGINS}; do
    source "${CURRENT_DIR}/${PLUGIN}/init.plugin.zsh"
done
