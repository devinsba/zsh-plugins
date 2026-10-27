ME="${(%):-%x}"
CURRENT_DIR=$(dirname ${ME})

PLUGINS=(
    "antidote-plugin-manager"
    "direnv"
    "fnm"
    "google-cloud-sdk"
    "gvm"
    "lmstudio"
    "nvm"
    "pyenv"
    "remctl"
    "rvm"
    "sdkman"
    "uv"
)

for PLUGIN in ${PLUGINS}; do
    source "${CURRENT_DIR}/${PLUGIN}/init.plugin.zsh"
done

source "${CURRENT_DIR}/theme.zsh"
